import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pie/lib/color.dart';
import 'package:pie/lib/global.dart';
import 'package:sqflite/sqflite.dart';

const double pagePaddingSize = 16;
const pagePadding = EdgeInsets.all(pagePaddingSize);
const double widgetSpacingHeight = 20;
const widgetSpacing = SizedBox(height: widgetSpacingHeight);
const double logoSideLen = 100;
const double blockButtonPadding = 16;
const double blockButtonTextSize = 16;
final primaryColor = createMaterialColor(0x7272ba /* 0x9292dc,*/);
const secondaryColor = Color(0xff9a9aee);
const chatTileColor = Color(0xffafafd7);

const kSize = 24;
const idLen = kSize;
const alpha = 3;

const userCertHashLen = 20;
const contactsAddingTokenLen = 5;

const metaDataRedundancy = 12;
const fileDataRedundancy = 4;
final maxRedundancy = max(metaDataRedundancy, fileDataRedundancy);

const chatListPageLen = 30;
const contactListPageLen = 30;
const numMessageLoad = 20;

const maxMessageLen = 2 * 1024 * 1024;

const maxAddrLen = 47;

const certFileName = 'id.cert';
const keyFileName = 'id.key';
const certPEMLen = 302;
const keyPEMLen = 119;
const certDERLen = 182;

const sendMsgTimeout = 3000;
const recvResTimeout = 6000;
const serverRecvMsgTimeout = 30000;

const fileBlockSize = 1 * 1024 * 1024;

class Config {
  static const currAccount = _ConfigItem('current_account', 'blob');

  static Future<Object?> query(_ConfigItem key, [Transaction? txn]) async {
    final results = await getHandler(txn).query('config', where: "key = ?", whereArgs: [key.key]);
    if (results.isNotEmpty) return results.first[key.column];
    return null;
  }

  static Future insert(_ConfigItem key, Object value, [Transaction? txn]) async {
    await getHandler(txn).insert('config', {'key': key.key, key.column: value}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future update(_ConfigItem key, Object value, [Transaction? txn]) async {
    await getHandler(txn).update('config', {key.column: value}, where: "key = ?", whereArgs: [key.key]);
  }

  static DatabaseExecutor getHandler(Transaction? txn) {
    return txn ?? mainDB;
  }
}

class _ConfigItem {
  final String key;
  final String column;

  const _ConfigItem(this.key, this.column);
}
