class PaginatedData<T> {
  final int? total;
  final int current;
  final bool haveNext;
  final List<T> items;

  PaginatedData({
    required this.total,
    required this.current,
    required this.haveNext,
    required this.items,
  });
}
