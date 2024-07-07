import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:komikoo/constants/height_constants.dart';
import 'package:komikoo/domain/controllers/comic_controller.dart';
import 'package:komikoo/domain/models/comic/comic_compact.dart';
import 'package:komikoo/domain/models/core/paginated_data.dart';
import 'package:komikoo/presentation/widgets/card/comic_compact_card.dart';
import 'package:komikoo/presentation/widgets/pagination/paginated_child_builder_delegate.dart';
import 'package:komikoo/presentation/widgets/pagination/paginated_view.dart';
import 'package:komikoo/typedefs.dart';

@RoutePage()
class ExplorePage extends ConsumerStatefulWidget {
  final String title;
  final Map<String, dynamic> options;

  const ExplorePage({super.key, required this.title, required this.options});

  @override
  ConsumerState<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage> {
  final PagingController<int, ComicCompact> _pagingController =
      PagingController(firstPageKey: 1);

  FutureEither<PaginatedData<ComicCompact>> _fetchPage(int page) {
    return ref.read(comicControllerProvider).filter(
          widget.options,
          page,
        );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PaginatedView(
        pagingController: _pagingController,
        fetchData: _fetchPage,
        child: PagedGridView<int, ComicCompact>(
          pagingController: _pagingController,
          padding: const EdgeInsets.all(10.5),
          showNoMoreItemsIndicatorAsGridChild: false,
          showNewPageErrorIndicatorAsGridChild: false,
          showNewPageProgressIndicatorAsGridChild: false,
          builderDelegate: PaginatedChildBuilderDelegate(
            pagingController: _pagingController,
            itemBuilder: (context, item, index) => ComicCompactCard(data: item),
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: HeightConstants.coverRatio,
          ),
        ),
      ),
    );
  }
}
