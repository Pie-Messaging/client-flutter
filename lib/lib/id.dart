import 'dart:collection';
import 'dart:ffi';
import 'dart:math';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:ffi/ffi.dart';
import 'package:pie/core/generated_core_bindings.dart';
import 'package:pie/lib/config.dart';
import 'package:pie/lib/global.dart';

class ID with IterableMixin<int> {
  late final Uint8List l;

  ID(this.l);

  ID.fromList(List<int> l) : l = Uint8List.fromList(l);

  ID.generate() {
    final randomer = Random.secure();
    l = List.generate(idLen, (_) => randomer.nextInt(0xff)).toUint8List();
  }

  @override
  toString() => toHexStr();

  String toHexStr() => hex.encode(l);

  List<int> toIntList() => l.toList();

  operator [](int i) => l[i];

  operator []=(int i, int v) => l[i] = v;

  @override
  Iterator<int> get iterator => l.iterator;

  @override
  operator ==(other) => hashCode == other.hashCode;

  @override
  int get hashCode => Object.hashAll(l);

  int b(int i) => l[i ~/ 8] >>> (8 - i % 8) & 1;
}

extension StringIDExt on String {
  List<int> toHexList() => hex.decode(this);

  Uint8List toUint8List() => Uint8List.fromList(toHexList());

  ID toID() => ID.fromList(toHexList());
}

extension ListIntIDExt on List<int> {
  String toHexStr() => hex.encode(this);

  Uint8List toUint8List() => Uint8List.fromList(this);

  ID toID() => ID.fromList(this);
}

extension IDExt on Uint8List {
  String toHexStr() => hex.encode(this);

  ID toID() => ID.fromList(this);
}

hashBytes(Uint8List bytes, Pointer<Uint8> result, int len) {
  final dataDataPtr = malloc<Uint8>(bytes.length)..asTypedList(bytes.length).setAll(0, bytes);
  final dataPtr = malloc<GoSlice>()
    ..ref.data = dataDataPtr.cast<Void>()
    ..ref.len = bytes.length
    ..ref.cap = bytes.length;
  final resultPtr = malloc<GoSlice>()
    ..ref.data = result.cast<Void>()
    ..ref.len = len
    ..ref.cap = len;
  core.HashBytes(dataPtr.ref, resultPtr.ref);
  malloc.free(resultPtr);
  malloc.free(dataPtr);
  malloc.free(dataDataPtr);
}
