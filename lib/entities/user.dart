import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:pie/entities/account.dart';
import 'package:pie/entities/chat.dart';
import 'package:pie/lib/address.dart';
import 'package:pie/lib/config.dart';
import 'package:pie/lib/global.dart';
import 'package:pie/lib/id.dart';
import 'package:pie/lib/log.dart';
import 'package:pie/net/net.dart';
import 'package:pie/protobuf/core.pb.dart' as pb;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

class User extends ChangeNotifier {
  late final ChangeNotifierProvider<User> pro;
  late final Account account;
  Chat? chat;
  late final ID id;
  late UserState state;
  late String name;
  late String email;
  late String bio;
  late bool hasAvatar;
  Uint8List? avatarBytes;
  late String contactName;
  late Addr addr;
  late Uint8List certDER;
  Session? session;
  final loadSession = Completer();
  var _loadingSession = false;

  User(this.id) {
    pro = ChangeNotifierProvider((_) => this);
  }

  User.fromRow(Map<String, Object?> row) {
    id = (row['u_id'] as Uint8List).toID();
    setFromRow(row);
  }

  setFromRow(Map<String, Object?> row) {
    state = UserState.values[row['u_state'] as int];
    name = row['u_name'] as String;
    email = row['u_email'] as String;
    bio = row['u_bio'] as String;
    hasAvatar = row['u_has_avatar'] as int == 1;
    contactName = row['u_contact_name'] as String;
    addr = (jsonDecode(row['u_addr'] as String) as List).toAddr(0);
    certDER = row['u_cert_der'] as Uint8List;
    notifyListeners();
  }

  String get avatarPath => join(account.filesDir, id.toHexStr());

  setName(String name) {
    this.name = name;
    notifyListeners();
  }

  setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  setBio(String bio) {
    this.bio = bio;
    notifyListeners();
  }

  setAvatar(Uint8List bytes) {
    hasAvatar = bytes.isNotEmpty;
    avatarBytes = bytes;
    notifyListeners();
  }

  setContactName(String contactName) {
    this.contactName = contactName;
    notifyListeners();
  }

  Future ensureSession(int ctx) async {
    if (_loadingSession) {
      await loadSession.future;
      return;
    }
    _loadingSession = true;
    logger.d('connect to user: $id ${addr.keys.first}');
    if (DateTime.now().millisecondsSinceEpoch - addr.values.first > 10 * 1000) {
      addr = (await routingTable.findUser(ctx, id))!.addr;
    }
    session ??= await account.client.connectServer(ctx, addr.keys.first, certDER);
    logger.d('connected to user: $id ${addr.keys.first}');
    // FIXME: send info to peer if the state is no-relation, and delete the info in add-contact-req
    loadSession.complete();
  }

  Future addContact(int ctx, String token) async {
    await ensureSession(ctx);
    final stream = await session!.sendMessage(
      pb.NetMessage(
        addContactReq: pb.AddContactReq(
            token: token,
            user: pb.User(
              name: account.name,
              email: account.email,
              bio: account.bio,
              avatar: account.avatarBytes,
            )),
      ),
      sendMsgTimeout,
    );
    final response = await stream.recvMessage(recvResTimeout);
    stream.close();
    if (response.hasAddContactRes()) {
      if (response.ensureAddContactRes().status == pb.Status.OK) {
        return;
      }
    }
  }

  Future approvalContact(int ctx) async {
    await Future.wait([
      account.db.update('user', {'u_state': UserState.contactAdded.index}, where: 'hex(u_id) = ?', whereArgs: [hex(id.l)]),
      () async {
        ensureSession(ctx);
        final stream = await session!.sendMessage(pb.NetMessage(approvalContactAddingReq: pb.ApprovalContactAddingReq()), sendMsgTimeout);
        final response = await stream.recvMessage(recvResTimeout);
        stream.close();
        if (response.hasApprovalContactAddingRes()) {
          if (response.ensureApprovalContactAddingRes().status == pb.Status.OK) {
            return;
          }
        }
      }(),
    ]);
    state = UserState.contactAdded;
    notifyListeners();
  }

  save([Transaction? txn]) async {
    final handler = txn ?? account.db;
    await Future.wait([
      if (hasAvatar) File(avatarPath).writeAsBytes(avatarBytes!, flush: true),
      handler.insert(
        'user',
        {
          'u_id': id.l,
          'u_state': state.index,
          'u_name': name,
          'u_email': email,
          'u_bio': bio,
          'u_has_avatar': hasAvatar ? 1 : 0,
          'u_contact_name': contactName,
          'u_addr': addr.toJSON(),
          'u_cert_der': certDER,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      ),
    ], eagerError: true);
  }
}

enum UserState {
  noRelation,
  peerAddingContact,
  selfAddingContact,
  contactAdded,
}
