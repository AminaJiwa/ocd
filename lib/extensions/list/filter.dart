//we are extneding any stream that has a value of T
//using the filter function we can then access that T
//T IS DATABASE NOTE
extension Filter<T> on Stream<List<T>> {
  //filter function passes T to the where function
  Stream<List<T>> filter(bool Function(T) where) =>
      map((items) => items.where(where).toList());
}
