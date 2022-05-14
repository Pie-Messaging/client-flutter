import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie/entities/account.dart';
import 'package:pie/entities/file.dart';
import 'package:pie/entities/group.dart';
import 'package:pie/entities/message.dart';
import 'package:pie/entities/user.dart';
import 'package:pie/lib/config.dart';
import 'package:pie/lib/global.dart';
import 'package:pie/lib/id.dart';
import 'package:pie/lib/log.dart';
import 'package:pie/lib/notifier.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

class Chat extends ChangeNotifier {
  late final ChangeNotifierProvider<Chat> pro;
  late final Account account;
  final ID id;
  final ChatType type;
  late final User? user;
  late final Group? group;
  late final messages = NotifierListQueueNotifier<Message>(ListQueue.of([]));
  late final messagesPro = ChangeNotifierProvider<NotifierListQueueNotifier<Message>>((ref) => messages);
  DateTime time;
  late DateTime lastReadMsgTime;
  var numUnread = 0;

  Chat(this.account, this.id, this.type, {required this.time, this.user, this.group, DateTime? lastReadMsgTime, this.numUnread = 0}) {
    pro = ChangeNotifierProvider((_) => this);
    this.lastReadMsgTime = lastReadMsgTime ?? time;
  }

  Future<int> loadMoreMessages() async {
    if (messages.isEmpty) return 0;
    final results = await account.db.rawQuery(
      '''
        SELECT * FROM message
        LEFT JOIN message_file ON mf_message_id = m_id
        WHERE m_chat_id = ? AND m_time < ?
        ORDER BY m_time DESC
        LIMIT $numMessageLoad
      ''',
      [id.toHexStr(), providers.read(messages.l.first).time.microsecondsSinceEpoch],
    );
    logger.d('loadMessages: ${results.length}');
    final visited = <ID, Message>{};
    for (final row in results) {
      late final Message message;
      final messageID = (row['m_id'] as Uint8List).toID();
      if (visited.containsKey(messageID)) {
        message = visited[messageID]!;
      } else {
        message = Message.fromRow(row)
          ..account = account
          ..chatID = id;
        visited[message.id] = message;
        messages.addFirst(message);
      }
      if (row['mf_file_id'] != null) {
        message.files.add(MsgFile(account, MsgFileType.unknown)..id = (row['mf_file_id'] as Uint8List).toID());
      }
    }
    return visited.length;
  }

  setLastReadMsgTime(DateTime dateTime) {
    if (lastReadMsgTime.microsecondsSinceEpoch <= dateTime.microsecondsSinceEpoch) return;
    lastReadMsgTime = dateTime;
    notifyListeners();
    account.db.update('chat', {'c_last_read_msg_time': dateTime.microsecondsSinceEpoch}, where: 'hex(c_id) = ?', whereArgs: [hex(id.l)]);
    logger.d('chat: set last read message time');
  }

  save([Transaction? txn]) async {
    final handler = txn ?? account.db;
    await handler.insert(
      'chat',
      {
        'c_id': id.l,
        'c_type': type.index,
        'c_time': time.microsecondsSinceEpoch,
        'c_last_read_msg_time': lastReadMsgTime.microsecondsSinceEpoch,
        'c_num_unread': numUnread,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  addMessage(Message message) {
    messages.add(message);
    time = message.time;
    notifyListeners();
  }

  addFirstMessage(Message message) {
    messages.addFirst(message);
    time = message.time;
    notifyListeners();
  }

  addUnreadMessage(Message message) {
    messages.add(message);
    time = message.time;
    numUnread++;
    logger.d('addUnreadMessage: $numUnread');
    notifyListeners();
  }
}

enum ChatType {
  system,
  private,
  group,
}
