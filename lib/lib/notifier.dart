import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie/lib/list.dart';

class ListNotifier<E> extends ChangeNotifier {
  final List<E> l;

  ListNotifier(this.l);

  add(E e) {
    l.add(e);
    notifyListeners();
  }

  addAll(Iterable<E> data) {
    l.addAll(data);
    notifyListeners();
  }

  removeAt(int index) {
    l.removeAt(index);
    notifyListeners();
  }

  E operator [](int index) => l[index];

  get length => l.length;

  bool get isEmpty => l.isEmpty;

  bool get isNotEmpty => l.isNotEmpty;
}

class OrderedListNotifier<E> extends ChangeNotifier {
  final OrderedList<E> l;

  OrderedListNotifier(this.l);

  add(E e) {
    l.add(e);
    notifyListeners();
  }

  insertOrdered(E e) {
    l.insertOrdered(e);
    notifyListeners();
  }

  removeAt(int index) {
    l.removeAt(index);
    notifyListeners();
  }

  E operator [](int index) => l[index];

  get length => l.length;

  bool get isEmpty => l.isEmpty;

  bool get isNotEmpty => l.isNotEmpty;
}

class ListQueueNotifier<E> extends ChangeNotifier {
  late final ListQueue<E> l;

  ListQueueNotifier(this.l);

  add(E e) {
    l.add(e);
    notifyListeners();
  }

  addFirst(E e) {
    l.addFirst(e);
    notifyListeners();
  }

  remove(E e) {
    l.remove(e);
    notifyListeners();
  }

  E operator [](int index) => l.elementAt(index);

  get length => l.length;

  bool get isEmpty => l.isEmpty;

  bool get isNotEmpty => l.isNotEmpty;
}

class MapNotifier<K, V> extends ChangeNotifier {
  late final Map<K, V> m;

  MapNotifier(this.m);

  operator []=(K key, V value) {
    m[key] = value;
    notifyListeners();
  }

  remove(K key) {
    m.remove(key);
    notifyListeners();
  }

  V? operator [](K key) => m[key];

  get length => m.length;

  bool get isEmpty => m.isEmpty;

  bool get isNotEmpty => m.isNotEmpty;
}

class NotifierListNotifier<E extends ChangeNotifier> extends ChangeNotifier {
  final List<ChangeNotifierProvider<E>> l;

  NotifierListNotifier(this.l);

  ChangeNotifierProvider<E> add(E e) {
    final changeNotifierProvider = ChangeNotifierProvider((ref) => e);
    l.add(changeNotifierProvider);
    notifyListeners();
    return changeNotifierProvider;
  }

  addAll(Iterable<E> data) {
    l.addAll(data.map((e) => ChangeNotifierProvider((ref) => e)));
    notifyListeners();
  }

  ChangeNotifierProvider<E> operator [](int index) => l[index];

  int get length => l.length;

  bool get isEmpty => l.isEmpty;

  bool get isNotEmpty => l.isNotEmpty;
}

class NotifierListQueueNotifier<E extends ChangeNotifier> extends ChangeNotifier {
  final ListQueue<ChangeNotifierProvider<E>> l;

  NotifierListQueueNotifier(this.l);

  ChangeNotifierProvider<E> add(E e) {
    final changeNotifierProvider = ChangeNotifierProvider((ref) => e);
    l.add(changeNotifierProvider);
    notifyListeners();
    return changeNotifierProvider;
  }

  ChangeNotifierProvider<E> addFirst(E e) {
    final changeNotifierProvider = ChangeNotifierProvider((ref) => e);
    l.addFirst(changeNotifierProvider);
    notifyListeners();
    return changeNotifierProvider;
  }

  remove(E e) {
    l.remove(e);
    notifyListeners();
  }

  ChangeNotifierProvider<E> operator [](int index) => l.elementAt(index);

  int get length => l.length;

  bool get isEmpty => l.isEmpty;

  bool get isNotEmpty => l.isNotEmpty;
}
