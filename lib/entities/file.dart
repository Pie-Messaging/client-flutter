import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:pie/entities/account.dart';
import 'package:pie/entities/message.dart';
import 'package:pie/lib/id.dart';
import 'package:sqflite/sqflite.dart';

class MsgFile {
  final Account account;
  final List<Message> messages = [];
  ID? id;
  final MsgFileType type;
  late final String name;
  late String path;
  final loading = Completer();
  late final FutureProvider loadingPro;

  MsgFile(this.account, this.type) {
    loadingPro = FutureProvider((_) async => await loading.future);
  }

  complete([String? p]) {
    path = p ?? join(account.filesDir, id!.toHexStr());
    if (!loading.isCompleted) loading.complete(path);
  }

  Future<int> save([Transaction? txn]) async {
    final handler = txn ?? account.db;
    return await handler.insert(
      'file',
      {
        'f_id': id?.l,
        'f_name': name,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

enum MsgFileType {
  unknown,
  image,
  audio,
  video,
  text,
}
