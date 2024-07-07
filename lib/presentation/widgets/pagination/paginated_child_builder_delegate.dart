import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:komikoo/presentation/widgets/error_view.dart';
import 'package:komikoo/presentation/widgets/loader.dart';

class PaginatedChildBuilderDelegate<PageKeyType, ItemType>
    extends PagedChildBuilderDelegate<ItemType> {
  PaginatedChildBuilderDelegate({
    double? loaderHeight,
    required super.itemBuilder,
    required PagingController<PageKeyType, ItemType> pagingController,
  }) : super(
          firstPageProgressIndicatorBuilder: (context) => SizedBox(
            height: loaderHeight,
            child: const Loader(),
          ),
          firstPageErrorIndicatorBuilder: (context) => ErrorView(
            message: pagingController.error.toString(),
            onRetry: pagingController.retryLastFailedRequest,
          ),
          newPageErrorIndicatorBuilder: (context) => ErrorView(
            message: pagingController.error.toString(),
          ),
        );
}
