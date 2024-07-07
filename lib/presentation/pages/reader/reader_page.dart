import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:komikoo/domain/controllers/comic_controller.dart';
import 'package:komikoo/domain/models/chapter/chapter.dart';
import 'package:komikoo/domain/providers/reading_progress_manager_provider.dart';
import 'package:komikoo/presentation/pages/reader/widgets/chapter_list_drawer.dart';
import 'package:komikoo/presentation/pages/reader/widgets/reader_overlay.dart';
import 'package:komikoo/presentation/pages/reader/widgets/webtoon_reader.dart';
import 'package:komikoo/presentation/widgets/error_view.dart';
import 'package:komikoo/presentation/widgets/loader.dart';

@RoutePage()
class ReaderPage extends ConsumerStatefulWidget {
  final String comicSlug;
  final String hid;

  const ReaderPage({
    super.key,
    required this.comicSlug,
    required this.hid,
  });

  @override
  ConsumerState<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends ConsumerState<ReaderPage> {
  final _scaffold = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();

  late GetChapterProvider provider = getChapterProvider(widget.hid);
  late ReadingProgressManagerProvider managerProvider =
      readingProgressManagerProvider(widget.comicSlug);
  bool overlayVisible = true;
  bool drawerOpened = false;

  int? currentIndex;
  List<Chapter>? chapterList;

  @override
  void initState() {
    super.initState();
    _toggleOverlay();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _updateOverlay(true);
    super.dispose();
  }

  void _toggleOverlay() {
    setState(() {
      overlayVisible = !overlayVisible;
    });
    _updateOverlay(overlayVisible);
  }

  void _hideOverlay() {
    if (overlayVisible) _toggleOverlay();
  }

  void _updateOverlay(show) {
    if (show) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    }
  }

  void _updateState(
    String comicSlug,
    int currentIndex,
    List<Chapter> chapterList,
  ) {
    final indexChanged = this.currentIndex != currentIndex;
    final chapterListChanged =
        (this.chapterList?.length ?? 0) < chapterList.length;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(managerProvider.notifier).setChapter(chapterList[currentIndex]);
      if (this.currentIndex == null) {
        ref
            .read(managerProvider.notifier)
            .setChapter(chapterList[currentIndex]);
      }

      if (indexChanged || chapterListChanged) {
        setState(() {
          if (indexChanged) this.currentIndex = currentIndex;
          if (chapterListChanged) this.chapterList = chapterList;
        });
      }
    });
  }

  void _onDrawer(bool opened) {
    _updateOverlay(opened || overlayVisible);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        drawerOpened = opened;
      });
    });
  }

  Chapter? _getChapter(int index) {
    if (index < 0) return null;

    return chapterList?.elementAtOrNull(index);
  }

  void _loadChapter(int index) {
    _scaffold.currentState?.closeDrawer();
    ref.read(managerProvider.notifier).resetChapter();

    setState(() {
      currentIndex = index;
      provider = getChapterProvider(chapterList![index].hid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffold,
      backgroundColor: theme.colorScheme.scrim,
      drawer: Drawer(
        child: ChapterListDrawer(
          currentIndex: currentIndex,
          chapterList: chapterList,
          onTap: _loadChapter,
          onState: _onDrawer,
        ),
      ),
      body: GestureDetector(
        onTap: _toggleOverlay,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            ref.watch(provider).when(
                  skipLoadingOnReload: false,
                  skipLoadingOnRefresh: false,
                  data: (data) {
                    _updateState(
                      data.comic.slug,
                      data.currentIndex,
                      data.chapterList,
                    );

                    return WebtoonReader(
                      totalHeight: data.totalHeight,
                      hideOverlay: _hideOverlay,
                      contents: data.contents,
                      managerProvider: managerProvider,
                    );
                  },
                  error: (error, stackTrace) => ErrorView(
                    message: error.toString(),
                    onRetry: () => ref.invalidate(provider),
                  ),
                  loading: () => const Loader(),
                ),
            ReaderOverlay(
              nextChapter:
                  currentIndex == null ? null : _getChapter(currentIndex! - 1),
              currentChapter: chapterList?.elementAtOrNull(currentIndex!),
              prevChapter:
                  currentIndex == null ? null : _getChapter(currentIndex! + 1),
              onNavigate: _loadChapter,
              overlayVisible: overlayVisible && !drawerOpened,
              managerProvider: managerProvider,
            ),
          ],
        ),
      ),
    );
  }
}
