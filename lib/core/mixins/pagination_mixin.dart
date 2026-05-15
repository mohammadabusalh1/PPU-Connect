import 'package:flutter/material.dart';

mixin PaginationMixin<T extends StatefulWidget> on State<T> {
  late final ScrollController paginationController;
  bool _fetchingMore = false;

  /// Override to load the next page. Set [_fetchingMore] to false when done.
  Future<void> fetchNextPage();

  void initPagination() {
    paginationController = ScrollController()..addListener(_onScroll);
  }

  void disposePagination() => paginationController.dispose();

  void resetFetchFlag() => _fetchingMore = false;

  void _onScroll() {
    if (_fetchingMore) return;
    final pos = paginationController.position;
    if (pos.pixels >= pos.maxScrollExtent - 200) {
      _fetchingMore = true;
      fetchNextPage();
    }
  }
}
