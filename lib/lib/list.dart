import 'package:collection/collection.dart';

class OrderedList<E> extends DelegatingList<E> {
  final List<E> l;
  final int Function(E, E) _compare;

  OrderedList(this.l, this._compare) : super(l);

  insertOrdered(E e) {
    lowerBound(l, e, compare: _compare);
  }

  E? search(E e) {
    final index = binarySearch(l, e, compare: _compare);
    return index >= 0 ? this[index] : null;
  }
}

// class OrderedListQueue<E> extends DelegatingQueue<E> {
//   final Queue<E> _l;
//   final int Function(E, E) _compare;
//
//   OrderedListQueue(this._l, this._compare) : super(_l);
//
//   operator [](int index) => _l.elementAt(index);
//
//   insertOrdered(E e) {
//     lowerBound(this, e, compare: _compare);
//   }
//
//   E? search(E e) {
//     final index = binarySearch(this, e, compare: _compare);
//     return index >= 0 ? elementAt(index) : null;
//   }
// }

extension ListBinaryActionExt<E> on List<E> {
  insertOrdered(E o, int Function(E, E)? compare) {
    lowerBound(this, o, compare: compare);
  }

  search(E o, int Function(E, E)? compare) {
    return binarySearch(this, o, compare: compare);
  }
}
