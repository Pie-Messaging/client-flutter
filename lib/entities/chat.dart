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
import 'package:pie/lib/id.dart';
import 'package:pie/lib/log.dart';
import 'package:pie/lib/notifier.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

class Chat extends ChangeNotifier {
  late final ChangeNotifierProvider<Chat> pro;
  late final Account account;
  late final ChatType type;
  late final User? user;
  late final Group? group;
  late final messages = ListQueueNotifier<Message>(ListQueue.of([]));
  late final messagesPro = ChangeNotifierProvider<ListQueueNotifier<Message>>((_) => messages);
  late DateTime time;
  Message? firstUnreadMsg;
  int numUnread;

  Chat(this.account, {this.user, this.group, this.firstUnreadMsg, this.numUnread = 0}) {
    pro = ChangeNotifierProvider((_) => this);
    if (user != null) {
      type = ChatType.private;
    } else if (group != null) {
      type = ChatType.group;
    } else {
      throw Exception('Chat type is not specified');
    }
  }

  ID get id => type == ChatType.private ? user!.id : group!.id;

  Future<int> loadMoreMessages() async {
    if (messages.isEmpty) return 0;
    final results = await account.db.rawQuery(
      '''
        SELECT * FROM message
        LEFT JOIN message_file ON mf_message_id = m_id
        WHERE hex(m_chat_id) = ? AND m_time < ?
        ORDER BY m_time DESC
        LIMIT $numMessageLoad
      ''',
      [hex(id.l), messages.l.first.time.microsecondsSinceEpoch],
    );
    logger.d('loadMessages: ${results.length}');
    final visited = <ID, Message>{};
    for (final row in results) {
      late final Message message;
      final messageID = (row['m_id'] as Uint8List).toID();
      if (visited.containsKey(messageID)) {
        message = visited[messageID]!;
      } else {
        message = Message.fromRow(row, account, this);
        visited[message.id] = message;
        messages.addFirst(message);
      }
      if (row['mf_file_id'] != null) {
        message.files.add(MsgFile(account, MsgFileType.unknown)..id = (row['mf_file_id'] as Uint8List).toID());
      }
    }
    return visited.length;
  }

  setMessageRead(Message message) {
    if (message.isRead != false) return;
    logger.d('set message read: is read: ${message.isRead}');
    message.setRead();
    firstUnreadMsg ??= message;
    numUnread--;
    notifyListeners();
    account.db.transaction((txn) async {
      await txn.update(
        'chat',
        {'c_first_unread_msg_id': firstUnreadMsg?.id.l, 'c_num_unread': numUnread},
        where: 'hex(c_id) = ?',
        whereArgs: [hex(id.l)],
      );
      await txn.update('message', {'m_is_read': 1}, where: 'hex(m_id) = ?', whereArgs: [hex(message.id.l)]);
    });
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
    firstUnreadMsg ??= message;
    numUnread++;
    logger.d('addUnreadMessage: $numUnread');
    notifyListeners();
  }

  save([Transaction? txn]) async {
    final handler = txn ?? account.db;
    await handler.insert(
      'chat',
      {
        'c_id': id.l,
        'c_type': type.index,
        'c_time': time.microsecondsSinceEpoch,
        'c_first_unread_msg_id': firstUnreadMsg?.id.l,
        'c_num_unread': numUnread,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

enum ChatType {
  system,
  private,
  group,
}
