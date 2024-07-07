import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:komikoo/constants/height_constants.dart';
import 'package:komikoo/domain/controllers/comic_controller.dart';
import 'package:komikoo/domain/controllers/favorite_controller.dart';
import 'package:komikoo/domain/controllers/history_controller.dart';
import 'package:komikoo/domain/models/chapter/chapter.dart';
import 'package:komikoo/domain/models/comic/comic.dart';
import 'package:komikoo/presentation/pages/details/widgets/chapter_list_item.dart';
import 'package:komikoo/presentation/widgets/error_view.dart';
import 'package:komikoo/presentation/widgets/loader.dart';
import 'package:komikoo/presentation/pages/details/widgets/chapter_list_header.dart';
import 'package:komikoo/presentation/pages/details/widgets/details_header.dart';
import 'package:komikoo/presentation/pages/details/widgets/synopsis_view.dart';
import 'package:komikoo/presentation/widgets/pagination/paginated_child_builder_delegate.dart';
import 'package:komikoo/presentation/widgets/pagination/paginated_view.dart';
import 'package:komikoo/router/app_router.gr.dart';

@RoutePage()
class DetailsPage extends ConsumerStatefulWidget {
  final String slug;

  const DetailsPage({super.key, required this.slug});

  @override
  ConsumerState<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends ConsumerState<DetailsPage> {
  final _scrollController = ScrollController();
  final _pagingController = PagingController<int, Chapter>(firstPageKey: 1);

  bool headerVisible = true;
  bool actionVisible = true;

  String? query;
  Language lang = Language.all;
  bool ascending = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateVisibility);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _updateVisibility() {
    final newHeaderVisible =
        _scrollController.offset < HeightConstants.headerEdge;
    final newActionVisible =
        _scrollController.offset < HeightConstants.actionEdge;

    if (newHeaderVisible == headerVisible &&
        newActionVisible == actionVisible) {
      return;
    }

    setState(() {
      headerVisible = _scrollController.offset < HeightConstants.headerEdge;
      actionVisible = _scrollController.offset < HeightConstants.actionEdge;
    });
  }

  void _toggleFavorite(bool isFavorite, Comic comic) {
    final controller = ref.read(favoriteControllerProvider);

    if (isFavorite) {
      controller.removeFromFavorite(comic.slug);
    } else {
      controller.addToFavorite(comic);
    }
  }

  void _openChapter(Comic comic, String hid) {
    ref.read(historyControllerProvider).updateComicEntry(comic);
    context.pushRoute(ReaderRoute(comicSlug: comic.slug, hid: hid));
  }

  void _changeLanguage(Language? lang) {
    this.lang = lang ?? Language.all;
    _pagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final minContentHeight = mediaQuery.size.height -
        kToolbarHeight -
        HeightConstants.chapterHeaderHeight -
        mediaQuery.padding.top;
    final maxVisibleChapter =
        minContentHeight / HeightConstants.chapterTileHeight;

    final isFavorite =
        ref.watch(isFavoriteProvider(widget.slug)).value ?? false;
    final provider = ref.watch(getDetailsProvider(widget.slug));
    final comic = provider.valueOrNull;

    return Scaffold(
      appBar: comic == null ? AppBar(leading: const AutoLeadingButton()) : null,
      floatingActionButton: comic?.firstChapter == null || actionVisible
          ? null
          : FloatingActionButton.extended(
              onPressed: () => _openChapter(comic, comic.firstChapter!.hid),
              icon: const Icon(Icons.import_contacts),
              label: Text('Read ${comic!.firstChapter!.getSimpleTitle()}'),
            ),
      body: provider.when(
        skipLoadingOnRefresh: false,
        data: (comic) => PaginatedView<Chapter>(
          pagingController: _pagingController,
          fetchData: (page) => ref
              .read(comicControllerProvider)
              .getChapters(comic.hid, page: page, lang: lang),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                leading: const AutoLeadingButton(),
                expandedHeight: HeightConstants.detailsHeaderHeight,
                titleSpacing: 0,
                title: Row(
                  children: [
                    Expanded(
                      child: AnimatedOpacity(
                        opacity: headerVisible ? 0 : 1,
                        duration: Durations.short2,
                        child: Text(comic.title),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: actionVisible ? 0 : 1,
                      duration: Durations.short2,
                      child: IconButton(
                        onPressed: () => _toggleFavorite(isFavorite, comic),
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_outline,
                          color: isFavorite ? Colors.red : null,
                        ),
                      ),
                    ),
                  ],
                ),
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1,
                  background: DetailsHeader(
                    comic: comic,
                    isFavorite: isFavorite,
                    toggleFavorite: () => _toggleFavorite(isFavorite, comic),
                    openChapter: _openChapter,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SynopsisView(
                  synopsis:
                      comic.description ?? 'Synopsis is not available yet',
                  callback: _updateVisibility,
                ),
              ),
              ChapterListHeader(
                languages: comic.languages,
                onLanguageChange: _changeLanguage,
              ),
              PagedSliverList(
                pagingController: _pagingController,
                builderDelegate: PaginatedChildBuilderDelegate(
                  pagingController: _pagingController,
                  loaderHeight: HeightConstants.chapterLoaderHeight,
                  itemBuilder: (context, item, index) => ChapterListItem(
                    data: item,
                    onTap: () => _openChapter(comic, item.hid),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ValueListenableBuilder(
                    valueListenable: _pagingController,
                    builder: (context, pagingState, _) {
                      final emptySpaceHeight =
                          _pagingController.itemList == null
                              ? minContentHeight -
                                  HeightConstants.chapterLoaderHeight
                              : _pagingController.itemList!.length <
                                      maxVisibleChapter
                                  ? minContentHeight -
                                      _pagingController.itemList!.length *
                                          HeightConstants.chapterTileHeight
                                  : HeightConstants.floatingButtonHeight;

                      return SizedBox(
                        height: emptySpaceHeight,
                      );
                    }),
              )
            ],
          ),
        ),
        error: (error, stackTrace) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(getDetailsProvider(widget.slug)),
        ),
        loading: () => const Loader(),
      ),
    );
  }
}
