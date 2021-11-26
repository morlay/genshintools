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
}

extension KtBool on bool {
  R? ifTrueOrNull<R>(R Function() f) => this ? f() : null;

  R? ifFalseOrNull<R>(R Function() f) => !this ? f() : null;
}
