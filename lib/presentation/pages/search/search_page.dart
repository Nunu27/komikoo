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
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _controller = PagingController<int, ComicCompact>(firstPageKey: 1);
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  FutureEither<PaginatedData<ComicCompact>> _fetchData(int page) {
    return ref.read(comicControllerProvider).filter({
      'q': _searchController.text,
    }, page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onSubmitted: (value) => _controller.refresh(),
          decoration: const InputDecoration(
            hintText: 'Search comic',
            border: InputBorder.none,
          ),
        ),
        titleSpacing: 0,
      ),
      body: PaginatedView(
        pagingController: _controller,
        fetchData: _fetchData,
        child: PagedGridView<int, ComicCompact>(
          pagingController: _controller,
          padding: const EdgeInsets.all(10.5),
          showNoMoreItemsIndicatorAsGridChild: false,
          showNewPageErrorIndicatorAsGridChild: false,
          showNewPageProgressIndicatorAsGridChild: false,
          builderDelegate: PaginatedChildBuilderDelegate(
            pagingController: _controller,
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
