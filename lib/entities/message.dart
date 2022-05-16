import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie/entities/account.dart';
import 'package:pie/entities/chat.dart';
import 'package:pie/entities/file.dart';
import 'package:pie/entities/sticker.dart';
import 'package:pie/lib/id.dart';
import 'package:sqflite/sqflite.dart';

class Message extends ChangeNotifier {
  late final ChangeNotifierProvider<Message> pro;
  late final Account account;
  late final Chat chat;
  late final ID id;
  late final bool isSysMsg;
  late final DateTime time;
  late final String content;
  final List contentMeta = [];
  final List<MsgFile> files = [];
  late final Sticker? sticker;
  late final ID? senderID;
  late final Message? forwardedFrom;
  late final Message? replyTo;
  bool? isRead;

  Message(
    this.account,
    this.chat,
    this.id,
    this.time,
    this.content, {
    this.isSysMsg = false,
    this.sticker,
    ID? senderID,
    this.forwardedFrom,
    this.replyTo,
    this.isRead,
  }) {
    pro = ChangeNotifierProvider((_) => this);
    senderID ??= chat.user?.id;
    // ignore: prefer_initializing_formals
    this.senderID = senderID;
  }

  Message.fromRow(Map<String, Object?> row, this.account, this.chat)
      : id = (row['m_id'] as Uint8List).toID(),
        isSysMsg = row['m_is_sys_msg'] == 1,
        time = DateTime.fromMicrosecondsSinceEpoch(row['m_time'] as int),
        content = row['m_content'] as String,
        senderID = (row['m_sender_id'] as Uint8List).toID(),
        isRead = row['m_is_read'] != null ? row['m_is_read'] as int == 1 : null {
    pro = ChangeNotifierProvider((_) => this);
  }

  setRead() {
    isRead = true;
    notifyListeners();
  }

  Future save([Transaction? txn]) async {
    final handler = txn ?? account.db;
    await handler.insert(
      'message',
      {
        'm_id': id.l,
        'm_chat_id': chat.id.l,
        'm_is_sys_msg': isSysMsg ? 1 : 0,
        'm_time': time.microsecondsSinceEpoch,
        'm_content': content,
        'm_sender_id': senderID?.l,
        'm_is_read': isRead != null ? (isRead! ? 1 : 0) : null,
        // TODO
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

enum MessageType {
  text,
  emoji,
  sticker,
}
