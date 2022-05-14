import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart' as notifications;
import 'package:path/path.dart';
import 'package:pie/core/generated_core_bindings.dart';
import 'package:pie/entities/account.dart';
import 'package:pie/entities/chat.dart';
import 'package:pie/entities/file.dart';
import 'package:pie/entities/message.dart';
import 'package:pie/entities/message_file_association.dart';
import 'package:pie/entities/user.dart';
import 'package:pie/lib/address.dart';
import 'package:pie/lib/config.dart';
import 'package:pie/lib/ffi.dart';
import 'package:pie/lib/global.dart';
import 'package:pie/lib/id.dart';
import 'package:pie/lib/log.dart';
import 'package:pie/net/net.dart';
import 'package:pie/protobuf/core.pb.dart' as pb;
import 'package:sqflite/utils/utils.dart';

class Server {
  late final Account account;
  final String listenAddr;
  late final String listenPort;
  final int cert;
  late final int server;

  Server(this.account, this.listenAddr, this.cert);

  Future start(int ctx) async {
    await listen();
    logger.d('server started');
    () async {
      await for (final session in acceptSession(ctx)) {
        handleSession(ctx, session);
      }
    }();
  }

  Future handleSession(int ctx, Session session) async {
    for (final stream in session.pendingStreams) {
      handleStream(ctx, stream);
    }
    while (true) {
      final stream = await session.acceptStream(ctx);
      handleStream(ctx, stream);
    }
  }

  Future handleStream(int ctx, QuicStream stream) async {
    var shouldContinue = true;
    while (shouldContinue) {
      final message = await stream.recvMessage(0);
      switch (message.whichBody()) {
        case pb.NetMessage_Body.addContactReq:
          await handleAddContactReq(ctx, stream, message.addContactReq);
          shouldContinue = false;
          break;
        case pb.NetMessage_Body.sendMessageReq:
          await handleSendMessageReq(ctx, stream, message.sendMessageReq);
          shouldContinue = false;
          break;
        case pb.NetMessage_Body.sendFileReq:
          await handleSendFileReq(ctx, stream, message.sendFileReq);
          shouldContinue = false;
          break;
        default:
          break;
      }
    }
  }

  Future handleAddContactReq(int ctx, QuicStream stream, pb.AddContactReq request) async {
    if (request.hasToken() && request.hasUser()) {
      if (await account.verifyAddingContactToken(request.token)) {
        final id = stream.session.user!.id;
        logger.d('add contact user id: $id');
        final user = stream.session.user!;
        user.setName(request.user.name);
        user.setEmail(request.user.email);
        user.setBio(request.user.bio);
        user.setAvatar(request.user.avatar.toUint8List());
        if (user.state == UserState.noRelation) {
          final chat = Chat(account, id, ChatType.private, time: DateTime.now());
          await account.db.transaction((txn) async {
            await user.save(txn);
            await chat.save(txn);
          });
          logger.d('user saved');
          await stream.sendMessage(pb.NetMessage(addContactRes: pb.AddContactRes(status: pb.Status.OK)), 0);
          if (providers.read(currAccountPro) == account) {
            user.chat = chat;
            account.chats.add(chat);
          }
          return;
        }
      }
    }
    logger.d('invalid add contact request');
    stream.session.close();
  }

  Future handleApprovalContactAddingReq(int ctx, QuicStream stream, pb.ApprovalContactAddingReq request) async {
    final user = stream.session.user!;
    final message = Message()
      ..account = account
      ..chatID = user.id
      ..id = ID.generate()
      ..isSysMsg = true
      ..time = DateTime.now()
      ..content = '对方同意添加你为联系人'
      ..senderID = user.id;
    await message.save();
    await stream.sendMessage(pb.NetMessage(approvalContactAddingRes: pb.ApprovalContactAddingRes(status: pb.Status.OK)), 0);
    stream.close();
    if (providers.read(currAccountPro) == account) {
      if (user.chat == null) {
        user.chat = Chat(account, user.id, ChatType.private, time: message.time, user: user);
        account.chats.add(user.chat!);
      }
    }
    final platformChannelSpecifics = notifications.NotificationDetails(
      android: notifications.AndroidNotificationDetails(
        account.id.toHexStr(),
        account.name,
        importance: notifications.Importance.max,
        priority: notifications.Priority.high,
        largeIcon: notifications.FilePathAndroidBitmap(user.avatarPath),
      ),
    );
    localNotifications.show(user.id.hashCode, user.name, '对方同意添加你为联系人', platformChannelSpecifics, payload: user.id.toHexStr());
  }

  Future handleSendMessageReq(int ctx, QuicStream stream, pb.SendMessageReq request) async {
    if (request.hasMessage()) {
      final pbMessage = request.message;
      if (pbMessage.hasId() && pbMessage.hasContent()) {
        final user = stream.session.user!;
        final message = Message()
          ..account = account
          ..chatID = user.id
          ..id = pbMessage.id.toID()
          ..isSysMsg = false
          ..time = DateTime.now()
          ..content = pbMessage.content
          ..files.addAll(Iterable.generate(pbMessage.files.length, (i) {
            final file = pbMessage.files[i];
            if (file.hasId()) {
              if (account.msgFiles.containsKey(file.id.toID())) return account.msgFiles[file.id.toID()]!;
              final msgFile = MsgFile(account, MsgFileType.unknown)
                ..id = file.id.toID()
                ..name = file.hasName() ? file.name : '';
              account.msgFiles[msgFile.id!] = msgFile;
              return msgFile;
            }
            if (account.msgMsgFiles.containsKey([pbMessage.id, i])) return account.msgMsgFiles[[pbMessage.id, i]]!;
            final msgFile = MsgFile(account, MsgFileType.unknown)..name = file.hasName() ? file.name : '';
            account.msgMsgFiles[[pbMessage.id, i]] = msgFile;
            return msgFile;
          }))
          ..senderID = user.id;
        await account.db.transaction((txn) async {
          await message.save(txn);
          for (var i = 0; i < message.files.length; i++) {
            message.files[i].messages.add(message);
            final fileID = await message.files[i].save(txn);
            await MsgFileAss(account, message.id, fileID).save(txn);
          }
        });
        await stream.sendMessage(pb.NetMessage(sendMessageRes: pb.SendMessageRes(status: pb.Status.OK)), 0);
        stream.close();
        if (providers.read(currAccountPro) == account) {
          if (user.chat == null) {
            user.chat = Chat(account, user.id, ChatType.private, time: message.time, user: user);
            account.chats.add(user.chat!);
          }
          user.chat!.addUnreadMessage(message);
        }
        final platformChannelSpecifics = notifications.NotificationDetails(
          android: notifications.AndroidNotificationDetails(
            account.id.toHexStr(),
            account.name,
            importance: notifications.Importance.max,
            priority: notifications.Priority.high,
            largeIcon: user.hasAvatar ? notifications.FilePathAndroidBitmap(user.avatarPath) : null,
          ),
        );
        localNotifications.show(user.id.hashCode, user.name, message.content, platformChannelSpecifics, payload: user.id.toHexStr());
        return;
      }
    }
    logger.d('invalid send message request');
    stream.session.close();
  }

  Future handleSendFileReq(int ctx, QuicStream stream, pb.SendFileReq request) async {
    if ((request.hasMessageId() && request.hasIndex() || request.hasFileId()) && request.hasSuffix() && request.hasSize()) {
      late final MsgFile msgFile;
      if (request.hasFileId()) {
        final fileID = request.fileId.toID();
        msgFile = account.msgFiles[fileID] ?? MsgFile(account, MsgFileType.unknown)
          ..id = fileID;
        account.msgFiles[fileID] = msgFile;
      } else {
        var msgMsgFileKey = [request.messageId.toID(), request.index];
        if (account.msgMsgFiles.containsKey(msgMsgFileKey)) {
          msgFile = account.msgMsgFiles[msgMsgFileKey]!;
        } else {
          msgFile = MsgFile(account, MsgFileType.unknown)..id = request.fileId.toID();
          account.msgMsgFiles[msgMsgFileKey] = msgFile;
        }
      }
      final dir = await Directory(join(account.filesDir, request.hasFileId() ? request.fileId.toHexStr() : request.messageId.toHexStr())).create();
      // TODO: preallocate file
      final file = File(join(dir.path, '${request.hasFileId() ? request.fileId.toHexStr() : request.index}${request.suffix}'));
      final io = file.openWrite();
      var read = 0;
      while (read < request.size.toInt()) {
        final data = await stream.recvData(recvResTimeout);
        read += data.length;
        io.add(data);
      }
      await io.close();
      logger.d('file received');
      msgFile.loading.complete();
      if (!await _ensureFileID(stream, request, file, msgFile)) {
        logger.d('invalid file id');
        stream.session.close();
        return;
      }
      await account.db.transaction((txn) async {
        await msgFile.save(txn);
        // if (request.hasFileId()) {
        //   await message.files[i].save(txn);
        //   await MsgFileAss(user, message.id, message.files[i].id).save(txn);
        // }
      });
      // final peerID = stream.session.user!.id;
      // await stream.sendMessage(pb.NetMessage(sendMessageRes: pb.SendMessageRes(status: pb.Status.OK)), 0);
      stream.close();
      return;
      // if (providers.read(currUserPro) == account.pro) {
      // final chats = providers.read(userState.chats);
      // final results = await userState.db.rawQuery(
      //   '''
      //   SELECT m_id, m_chat_id FROM message_file
      //   JOIN message ON m_id = mf_message_id
      //   WHERE mf_file_id = ?
      //   ''',
      //   [request.fileId.toHexStr()],
      // );
      // for (final row in results) {
      //   final chat = chats.l.firstWhere((chat) => providers.read(chat).id == (row['m_chat_id'] as Uint8List).toID());
      //   final message = providers.read(chat).messagesState.l.lastWhere((message) => providers.read(message).id == (row['m_id'] as Uint8List).toID());
      //   providers.read(message).addFile(file);
      // }
      // }
    }
    logger.d('invalid send file request');
    stream.session.close();
  }

  Future<bool> _ensureFileID(QuicStream stream, pb.SendFileReq request, File file, MsgFile msgFile) async {
    if (!request.hasFileId()) {
      final finishReq = await stream.recvMessage(recvResTimeout);
      if (finishReq.hasFinishSendFileReq()) {
        final finishMsg = finishReq.finishSendFileReq;
        if (finishMsg.hasFileId()) {
          msgFile.id = finishMsg.fileId.toID();
          // user.msgFiles[msgFile.id] = msgFile;
          await file.rename(join(account.filesDir, '${finishMsg.fileId}${request.suffix}'));
          return true;
        }
      }
    }
    return false;
  }

  Future listen() async {
    final result = await compute(_listen, _ServerListen(listenAddr, cert));
    server = result.r0;
    listenPort = result.r1.toString();
  }

  static ListenNet_return _listen(_ServerListen arg) {
    final listenAddrPtr = malloc<GoString>()
      ..ref.p = arg.listenAddr.toNativeUtf8().cast<Int8>()
      ..ref.n = arg.listenAddr.length;
    final result = core.ListenNet(listenAddrPtr.ref, arg.cert);
    malloc.free(listenAddrPtr);
    final server = result.r0;
    assert(server != 0);
    return result;
  }

  Stream<Session> acceptSession(int ctx) async* {
    final recvPort = ReceivePort();
    final errPort = ReceivePort();
    Isolate.spawn(_acceptSession, SpawnArg(null, _ServerAcceptSession(ctx, server), recvPort.sendPort), onError: errPort.sendPort);
    final streamController = StreamController<Session>();
    recvPort.listen((session) {
      _handleSession(ctx, streamController, session);
    });
    errPort.listen((error) {
      recvPort.close();
      errPort.close();
      streamController.addError(error);
    });
    yield* streamController.stream;
  }

  _handleSession(int ctx, StreamController<Session> streamController, session) async {
    session = session as Session;
    logger.d('accepted session: ${session.addr!.keys}');
    final start = DateTime.now();
    QuicStream stream;
    while (true) {
      if (DateTime.now().difference(start).inMilliseconds > serverRecvMsgTimeout) {
        session.close();
        return;
      }
      stream = await session.acceptStream(ctx);
      if (stream.streamID == 0) break;
      session.pendingStreams.add(stream);
    }
    final message = await stream.recvMessage(serverRecvMsgTimeout);
    final request = message.ensureClientCertReq();
    if (request.hasId() && request.hasServerCertSign()) {
      final id = request.id.toID();
      final User? user;
      if (account.users.containsKey(id)) {
        user = account.users[id];
      } else {
        final result = await account.db.query('user', where: 'hex(u_id) = ?', whereArgs: [hex(id.l)]);
        if (result.isNotEmpty) {
          user = User.fromRow(result.first);
        } else {
          user = await routingTable.findUser(ctx, id);
          if (user != null) {
            user.state = UserState.noRelation;
            user.avatarBytes = null;
          } else {
            logger.d('user not found');
            session.close();
            return;
          }
        }
        user.account = account;
      }
      final clientCertDERDataPtr = malloc<Uint8>(request.certDer.length)..asTypedList(request.certDer.length).setAll(0, request.certDer);
      final clientCertDERPtr = malloc<GoSlice>()
        ..ref.data = clientCertDERDataPtr.cast<Void>()
        ..ref.len = request.certDer.length
        ..ref.cap = request.certDer.length;
      final serverCertSignDataPtr = malloc<Uint8>(request.serverCertSign.length)
        ..asTypedList(request.serverCertSign.length).setAll(0, request.serverCertSign);
      final serverCertSignPtr = malloc<GoSlice>()
        ..ref.data = serverCertSignDataPtr.cast<Void>()
        ..ref.len = request.serverCertSign.length
        ..ref.cap = request.serverCertSign.length;
      if (core.VerifyClientCert(server, clientCertDERPtr.ref, serverCertSignPtr.ref) == 1) {
        session.user = user;
        streamController.add(session);
        logger.d('accepted verified session: ${session.user!.id}');
        return;
      }
    }
    logger.d('invalid client id cert message');
    session.close();
  }

  static _acceptSession(SpawnArg<void, _ServerAcceptSession> arg) {
    final addrDataPtr = malloc<Uint8>(maxAddrLen);
    final addrPtr = malloc<GoSlice>()
      ..ref.data = addrDataPtr.cast<Void>()
      ..ref.len = maxAddrLen
      ..ref.cap = maxAddrLen;
    late AcceptSession_return result;
    try {
      while (true) {
        // use loop to avoid blocking on ffi calls all the time or Flutter hot reload and hot restart will stuck
        while (true) {
          result = core.AcceptSession(arg.arg.ctx, arg.arg.listener, addrPtr.ref);
          final err = result.r2;
          if (checkErr(err, Error.timedOut)) break;
        }
        final session = result.r0;
        final addrLen = result.r1;
        final addr = [addrDataPtr.asTypedList(addrLen).toString()].toAddr();
        logger.d('accepted new session: ${addr.toString()}');
        arg.sendPort!.send(Session(session, addr: addr));
      }
    } catch (_) {
      rethrow;
    } finally {
      malloc.free(addrPtr);
      malloc.free(addrDataPtr);
    }
  }
}

class _ServerListen {
  final String listenAddr;
  final int cert;

  _ServerListen(this.listenAddr, this.cert);
}

class _ServerAcceptSession {
  final int ctx;
  final int listener;

  _ServerAcceptSession(this.ctx, this.listener);
}
