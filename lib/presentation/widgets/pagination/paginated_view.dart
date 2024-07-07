import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:komikoo/domain/models/core/paginated_data.dart';
import 'package:komikoo/typedefs.dart';

class PaginatedView<T> extends StatefulWidget {
  final PagingController<int, T> pagingController;
  final FutureEither<PaginatedData<T>> Function(int page) fetchData;
  final Widget child;

  const PaginatedView({
    super.key,
    required this.pagingController,
    required this.fetchData,
    required this.child,
  });

  @override
  State<PaginatedView<T>> createState() => _PaginatedViewState<T>();
}

class _PaginatedViewState<T> extends State<PaginatedView<T>> {
  bool refreshable = false;

  @override
  void initState() {
    super.initState();
    widget.pagingController.addPageRequestListener((pageKey) {
      _fetch(pageKey);
    });
    widget.pagingController.addStatusListener((status) {
      final newStatus = isRefreshable(status);
      if (newStatus == refreshable) return;

      setState(() {
        refreshable = newStatus;
      });
    });
  }

  bool isRefreshable(PagingStatus status) {
    switch (status) {
      case PagingStatus.completed:
      case PagingStatus.ongoing:
      case PagingStatus.subsequentPageError:
        return true;

      default:
        return false;
    }
  }

  void _fetch(int page) async {
    final result = await widget.fetchData(page);
    if (!mounted) return;

    result.fold(
      (error) => widget.pagingController.error = error.message,
      (data) {
        if (data.haveNext) {
          widget.pagingController.appendPage(data.items, page + 1);
        } else {
          widget.pagingController.appendLastPage(data.items);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      notificationPredicate: (_) => refreshable,
      onRefresh: () => Future.sync(widget.pagingController.refresh),
      child: widget.child,
    );
  }
}
