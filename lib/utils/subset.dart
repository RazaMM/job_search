extension Subset<E> on Set<E> {
  bool isSubset(Set<E> of) {
    if (length > of.length) return false;

    return of.containsAll(this);
  }

  bool isProperSubset(Set<E> of) {
    if (length >= of.length) return false;

    return of.containsAll(this);
  }

  bool isEqual(Set<E> other) {
    return this.isSubset(other) && other.isSubset(this);
  }
}
