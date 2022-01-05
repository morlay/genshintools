extension StdKt<T> on T {
  R let<R>(R Function(T it) block) {
    return block(this);
  }

  T also(void Function(T it) block) {
    block(this);
    return this;
  }
}

extension ListExtensions<E> on List<E> {
  E? getOrNull(int i) => (i >= 0 && i < length) ? this[i] : null;

  List<E> uniqBy<T>(T Function(E e) iteratee) {
    return fold<Map<T, E>>(
      {},
      (previousValue, e) => {
        ...previousValue,
        iteratee(e): e,
      },
    ).values.toList();
  }
}

extension KtBool on bool {
  R? ifTrueOrNull<R>(R Function() f) => this ? f() : null;

  R? ifFalseOrNull<R>(R Function() f) => !this ? f() : null;
}
