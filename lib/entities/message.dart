import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pie/entities/account.dart';
import 'package:pie/entities/file.dart';
import 'package:pie/entities/group.dart';
import 'package:pie/entities/sticker.dart';
import 'package:pie/entities/user.dart';
import 'package:pie/lib/id.dart';
import 'package:sqflite/sqflite.dart';

class Message extends ChangeNotifier {
  late final Account account;
  late final ID chatID;
  late final ID id;
  late final User? user;
  late final Group? group;
  late final bool isSysMsg;
  late final DateTime time;
  late final String content;
  final List contentMeta = [];
  final List<MsgFile> files = [];
  late final ID? senderID;
  late final Sticker? sticker;
  late final Message? forwardedFrom;
  late final Message? replyTo;

  Message();

  Message.fromRow(Map<String, Object?> row)
      : id = (row['m_id'] as Uint8List).toID(),
        isSysMsg = row['m_is_sys_msg'] == 1,
        time = DateTime.fromMicrosecondsSinceEpoch(row['m_time'] as int),
        content = row['m_content'] as String,
        senderID = (row['m_sender_id'] as Uint8List).toID();

  Future save([Transaction? txn]) async {
    final handler = txn ?? account.db;
    await handler.insert(
      'message',
      {
        'm_id': id.l,
        'm_chat_id': chatID.l,
        'm_is_sys_msg': isSysMsg ? 1 : 0,
        'm_time': time.microsecondsSinceEpoch,
        'm_content': content,
        'm_sender_id': senderID?.l,
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
