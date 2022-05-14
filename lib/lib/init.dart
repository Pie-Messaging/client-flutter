import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pie/core/generated_core_bindings.dart';
import 'package:pie/entities/account.dart';
import 'package:pie/lib/address.dart';
import 'package:pie/lib/config.dart';
import 'package:pie/lib/database.dart';
import 'package:pie/lib/global.dart';
import 'package:pie/lib/id.dart';
import 'package:pie/lib/log.dart';
import 'package:pie/lib/tracker.dart';

init() async {
  dataDir = await getApplicationSupportDirectory();

  final loadDB = () async {
    await loadMainDatabase();
  }();

  final logDir = Directory(join(dataDir.path, 'logs'));
  final firstRunning = !await logDir.exists();

  final loadAccounts = Completer();
  await Future.wait([
    localNotifications.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('app_icon'),
        macOS: MacOSInitializationSettings(),
      ),
      onSelectNotification: (String? payload) {
        logger.d('onSelectNotification: $payload');
      },
    ),
    () async {
      if (firstRunning) {
        await logDir.create();
      }
      final logFilePathDataPtr = join(logDir.path, 'core.log').toNativeUtf8();
      final logFilePathPtr = malloc<GoString>()
        ..ref.p = logFilePathDataPtr.cast<Int8>()
        ..ref.n = logFilePathDataPtr.length;
      core.SetLogOutput(logFilePathPtr.ref);
      malloc.free(logFilePathPtr);
      malloc.free(logFilePathDataPtr);
    }(),
    () async {
      accountsDir = Directory(join(dataDir.path, 'accounts'));
      if (firstRunning) {
        await accountsDir.create();
      } else {
        await loadDB;
        final accounts = await mainDB.query('account');
        for (final a in accounts) {
          final account = Account(
            (a['id'] as Uint8List).toID(),
            a['name'] as String,
            a['email'] as String,
            a['bio'] as String,
            a['has_avatar'] as int == 1,
            a['cert_pem'] as Uint8List,
            port: a['port'] as int,
          )..setCert(a['key_pem'] as Uint8List);
          providers.read(accountsPro).add(account);
          account.startup();
        }
        await Future.wait(
          providers.read(accountsPro).l.map((account) async {
            if (account.hasAvatar) account.avatarBytes = await File(account.avatarPath).readAsBytes();
          }),
          eagerError: true,
        );
      }
      loadAccounts.complete();
    }(),
    () async {
      if (firstRunning) {
        final List trackers = jsonDecode(await rootBundle.loadString('assets/trackers.json'));
        await loadDB;
        final batch = mainDB.batch();
        for (final tracker in trackers) {
          final id = (tracker['id'] as String).toID();
          routingTable.addTracker(Tracker(id, (tracker['addr'] as List).toAddr()));
          batch.insert('tracker', {'id': id.l, 'addr': jsonEncode(tracker['addr'])});
        }
        await batch.commit();
      } else {
        await loadDB;
        await routingTable.load();
        await loadAccounts.future;
        for (final account in providers.read(accountsPro).l) {
          account.announce();
        }
      }
    }(),
    () async {
      if (!firstRunning) {
        await loadDB;
        final currAccount = await Config.query(Config.currAccount);
        if (currAccount != null) {
          bool findAccount(Account account) => account.id == (currAccount as Uint8List).toID();
          final account = providers.read(accountsPro).l.firstWhere(findAccount);
          await account.load.future;
          providers.read(currAccountPro.notifier).set(account);
        }
      }
    }(),
  ], eagerError: true);
}
