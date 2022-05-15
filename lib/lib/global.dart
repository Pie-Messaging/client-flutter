import 'dart:ffi';
import 'dart:io';

import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart' as notifications;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie/core/generated_core_bindings.dart';
import 'package:pie/entities/account.dart';
import 'package:pie/entities/chat.dart';
import 'package:pie/lib/config.dart';
import 'package:pie/lib/init.dart';
import 'package:pie/lib/log.dart';
import 'package:pie/lib/notifier.dart';
import 'package:pie/lib/routing.dart';
import 'package:sqflite/sqflite.dart';

final providers = ProviderContainer();

final initPro = FutureProvider((ref) async {
  try {
    await init();
  } catch (e, s) {
    logger.e('Failed to init', e, s);
  }
});
final accountsPro = ChangeNotifierProvider<ListNotifier<Account>>((_) => ListNotifier([]));
final currAccountPro = StateNotifierProvider<AccountNotifier, Account?>((_) => AccountNotifier(null));
final chatPro = StateProvider<Chat?>((ref) => null);

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

final routingTable = RoutingTable();

final core = Core(DynamicLibrary.open('libcore.so')); // must be initialized now, or isolate thread can't access it

final localNotifications = notifications.FlutterLocalNotificationsPlugin();

late final Database mainDB;

late final Config config;

late final Directory dataDir;

late final Directory accountsDir;

late final Directory filesDir;

const listEquality = ListEquality();
