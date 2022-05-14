import 'dart:convert';

import 'package:collection/collection.dart';

class Addr extends DelegatingMap<String, int> {
  Addr([Map<String, int>? base]) : super(base ?? {});

  toJSON() => jsonEncode(keys.toList());
}

extension AddrExt on Map<String, int> {
  Addr toAddr() => Addr()..addAll(this);
}

extension AddrListExt on List<String> {
  Addr toAddr([int? timestamp]) => Addr()..addAll({for (final k in this) k: timestamp ?? DateTime.now().millisecondsSinceEpoch});
}

extension AddrDynamicListExt on List {
  Addr toAddr([int? timestamp]) => Addr()..addAll({for (final k in this) k as String: timestamp ?? DateTime.now().millisecondsSinceEpoch});
}
