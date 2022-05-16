import 'dart:async';
import 'dart:collection';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:pie/core/generated_core_bindings.dart';
import 'package:pie/entities/chat.dart';
import 'package:pie/entities/contact.dart';
import 'package:pie/entities/file.dart';
import 'package:pie/entities/message.dart';
import 'package:pie/entities/user.dart';
import 'package:pie/lib/address.dart';
import 'package:pie/lib/config.dart';
import 'package:pie/lib/database.dart';
import 'package:pie/lib/global.dart';
import 'package:pie/lib/id.dart';
import 'package:pie/lib/log.dart';
import 'package:pie/lib/notifier.dart';
import 'package:pie/lib/server.dart';
import 'package:pie/net/client.dart';
import 'package:sqflite/sqflite.dart';

// local user
class Account extends ChangeNotifier {
  late final ChangeNotifierProvider<Account> pro;
  final ID id;
  String name;
  String email;
  String bio;
  bool hasAvatar;
  Uint8List? avatarBytes;
  late final Addr addr;
  Uint8List certPEM;
  late int cert;
  late Uint8List certDER;
  int port;
  late final Client client;
  late final Server server;
  late final Database db;
  final contacts = ListNotifier<Contact>([]); // reverse order
  late final contactsPro = ChangeNotifierProvider<ListNotifier<Contact>>((_) => contacts);
  final chats = ListNotifier<Chat>([]); // reverse order
  late final chatsPro = ChangeNotifierProvider<ListNotifier<Chat>>((_) => chats);
  final users = <ID, User>{};
  final msgFiles = <ID, MsgFile>{};
  final msgMsgFiles = HashMap<List, MsgFile>(equals: listEquality.equals, hashCode: listEquality.hash, isValidKey: listEquality.isValidKey);
  final load = Completer();

  Account(this.id, this.name, this.email, this.bio, this.hasAvatar, this.certPEM, {this.port = 0}) {
    pro = ChangeNotifierProvider((_) => this);
  }

  String get accountDir => join(accountsDir.path, id.toHexStr());

  String get filesDir => join(accountDir, 'files');

  String get avatarPath => join(accountDir, 'avatar');

  setCert(Uint8List keyPEM) {
    final certPEMDataPtr = malloc<Uint8>(certPEM.length)..asTypedList(certPEM.length).setAll(0, certPEM);
    final certPEMPtr = malloc<GoSlice>()
      ..ref.data = certPEMDataPtr.cast<Void>()
      ..ref.len = certPEM.length
      ..ref.cap = certPEM.length;
    final keyDataPtr = malloc<Uint8>(keyPEM.length)..asTypedList(keyPEM.length).setAll(0, keyPEM);
    final keyPtr = malloc<GoSlice>()
      ..ref.data = keyDataPtr.cast<Void>()
      ..ref.len = keyPEM.length
      ..ref.cap = keyPEM.length;
    final certDERDataPtr = malloc<Uint8>(certDERLen);
    final certDERPtr = malloc<GoSlice>()
      ..ref.data = certDERDataPtr.cast<Void>()
      ..ref.len = certDERLen
      ..ref.cap = certDERLen;
    cert = core.X509KeyPair(certPEMPtr.ref, keyPtr.ref, certDERPtr.ref);
    certDER = certDERDataPtr.asTypedList(certDERLen).toUint8List();
    malloc.free(certDERPtr);
    malloc.free(certDERDataPtr);
    malloc.free(keyPtr);
    malloc.free(keyDataPtr);
    malloc.free(certPEMPtr);
    malloc.free(certPEMDataPtr);
    assert(cert != 0);
  }

  Future startup() async {
    client = Client(id, cert);
    server = Server(this, ':$port', cert);
    db = await loadAccountDatabase(accountDir);
    load.complete();
  }

  Future announce() async {
    try {
      await Future.wait([
        routingTable.findTracker(0, id),
        () async {
          late final Addr addrList;
          await Future.wait([
            server.start(0),
            () async {
              addrList = await routingTable.getAddr(0);
            }(),
          ], eagerError: true);
          addr = addrList.map((k, v) => MapEntry('[$k]:${server.listenPort}', v)).toAddr();
        }(),
      ], eagerError: true);
      await routingTable.putUser(0, this);
      logger.i('account: $id name:$name addr: ${addr.keys.first}');
    } catch (e, s) {
      logger.e('Failed to announce', e, s);
      scaffoldKey.currentState?.showSnackBar(const SnackBar(content: Text('网络错误，无法通知其他人我的上线')));
    }
  }

  Future loadContactsAndChats() async {
    final start = DateTime.now();
    await Future.wait([
      _loadContacts(),
      _loadChats(),
    ], eagerError: true);
    logger.d('load contacts and chats: ${DateTime.now().difference(start).inMilliseconds}ms');
  }

  Future _loadContacts() async {
    final results = await db.query(
      'user',
      where: 'u_state = ?',
      whereArgs: [UserState.contactAdded.index],
      orderBy: 'u_name',
      limit: contactListPageLen,
    );
    contacts.l.clear();
    contacts.addAll(results.map(
      (row) {
        final id = (row['u_id'] as Uint8List).toID();
        return Contact(this, users.putIfAbsent(id, () => User(id)..account = this).setFromRow(row));
      },
    ));
  }

  Future _loadChats() async {
    final results = await db.rawQuery(
      '''
        SELECT * FROM chat
        JOIN user ON u_id = c_id
        LEFT JOIN message ON m_id = (
          SELECT m_id FROM message
          WHERE m_chat_id = c_id
          ORDER BY m_time DESC
          LIMIT 1
        )
        LEFT JOIN message_file ON mf_message_id = m_id
        ORDER BY c_time
        LIMIT $chatListPageLen
      ''',
    );
    final visited = <ID, Chat>{};
    for (final row in results) {
      final id = (row['u_id'] as Uint8List).toID();
      final chat = visited[(row['c_id'] as Uint8List)] ??
          Chat(
            this,
            user: users.putIfAbsent(id, () => User(id)..account = this)..setFromRow(row),
            numUnread: row['c_num_unread'] as int,
          )
        ..time = DateTime.fromMicrosecondsSinceEpoch(row['c_time'] as int);
      if (row['m_id'] != null) {
        late final Message message;
        if (chat.messages.isNotEmpty) {
          // this row is about 2nd or later file of the only message
          message = chat.messages.l.last;
        } else {
          message = Message.fromRow(row, this, chat);
          chat.addFirstMessage(message);
        }
        if (row['mf_file_id'] != null) {
          message.files.add(MsgFile(this, MsgFileType.unknown)..id = (row['mf_file_id'] as Uint8List).toID());
        }
      }
      visited[chat.id] = chat;
    }
    chats.l.clear();
    chats.addAll(visited.values);
  }

  Future<bool> verifyAddingContactToken(String token) async {
    final result = await db.rawQuery('SELECT EXISTS(SELECT * FROM contact_adding_token WHERE token = ?)', [token]);
    return Sqflite.firstIntValue(result) == 1;
  }

  static Future<Account> create(String name, String email, String bio, PlatformFile? avatarFile) async {
    final id = ID.generate();
    final hasAvatar = avatarFile != null;

    final certPEMDataPtr = malloc<Uint8>(certPEMLen);
    final certPEMPtr = malloc<GoSlice>()
      ..ref.data = certPEMDataPtr.cast<Void>()
      ..ref.len = certPEMLen
      ..ref.cap = certPEMLen;
    final keyPEMDataPtr = malloc<Uint8>(keyPEMLen);
    final keyPEMPtr = malloc<GoSlice>()
      ..ref.data = keyPEMDataPtr.cast<Void>()
      ..ref.len = keyPEMLen
      ..ref.cap = keyPEMLen;
    final certDERDataPtr = malloc<Uint8>(certDERLen);
    final certDERPtr = malloc<GoSlice>()
      ..ref.data = certDERDataPtr.cast<Void>()
      ..ref.len = certDERLen
      ..ref.cap = certDERLen;
    final cert = core.GenerateKeyPair(certPEMPtr.ref, keyPEMPtr.ref, certDERPtr.ref);
    final certPEM = certPEMDataPtr.asTypedList(certPEMLen).toUint8List();
    final keyPEM = keyPEMDataPtr.asTypedList(keyPEMLen).toUint8List();
    final certDER = certDERDataPtr.asTypedList(certDERLen).toUint8List();

    final account = Account(id, name, email, bio, hasAvatar, certPEM)
      ..avatarBytes = avatarFile?.bytes
      ..cert = cert
      ..certDER = certDER;
    await Future.wait([
      () async {
        await mainDB.transaction((txn) async {
          await txn.insert(
            'account',
            {
              'id': id.l,
              'name': name,
              'email': email,
              'bio': bio,
              'has_avatar': hasAvatar ? 1 : 0,
              'cert_pem': certPEM,
              'key_pem': keyPEM,
              'port': account.port,
            },
          );
          await Config.insert(Config.currAccount, id.l, txn);
        });
      }(),
      () async {
        await Directory(account.accountDir).create();
        await Future.wait([
          Directory(account.filesDir).create(),
          if (hasAvatar) File(avatarFile.path!).rename(account.avatarPath),
        ], eagerError: true);
      }(),
    ], eagerError: true);
    malloc.free(keyPEMPtr);
    malloc.free(keyPEMDataPtr);
    malloc.free(certPEMPtr);
    malloc.free(certPEMDataPtr);
    return account;
  }
}

class AccountNotifier extends StateNotifier<Account?> {
  AccountNotifier([Account? current]) : super(current);

  set(Account current) {
    state = current;
    state!.loadContactsAndChats();
  }
}
