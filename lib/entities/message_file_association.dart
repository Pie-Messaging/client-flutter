import 'package:pie/entities/account.dart';
import 'package:pie/lib/id.dart';
import 'package:sqflite/sqflite.dart';

class MsgFileAss {
  final Account account;
  ID msgID;
  int fileID;

  MsgFileAss(this.account, this.msgID, this.fileID);

  Future save([Transaction? txn]) async {
    final handler = txn ?? account.db;
    await handler.insert(
      'message_file',
      {
        'mf_message_id': msgID.l,
        'mf_file_id': fileID,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
