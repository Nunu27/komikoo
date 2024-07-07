import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:komikoo/constants/height_constants.dart';
import 'package:komikoo/domain/models/chapter/chapter.dart';
import 'package:komikoo/domain/providers/reading_progress_manager_provider.dart';

class ReaderOverlay extends ConsumerWidget {
  final Chapter? nextChapter;
  final Chapter? currentChapter;
  final Chapter? prevChapter;
  final void Function(int index) onNavigate;
  final bool overlayVisible;
  final ReadingProgressManagerProvider managerProvider;

  const ReaderOverlay({
    super.key,
    required this.nextChapter,
    required this.currentChapter,
    required this.prevChapter,
    required this.onNavigate,
    required this.overlayVisible,
    required this.managerProvider,
  });

  void _next() {
    onNavigate(nextChapter!.index);
  }

  void _prev() {
    onNavigate(prevChapter!.index);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final percentage = ref.watch(managerProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnimatedSlide(
          duration: Durations.medium1,
          offset: Offset(0, overlayVisible ? 0 : -1),
          curve: Curves.easeInOut,
          child: AppBar(
            scrolledUnderElevation: 0,
            leading: const AutoLeadingButton(),
            title: currentChapter == null
                ? null
                : Text(currentChapter!.getSimpleTitle()),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              )
            ],
          ),
        ),
        AnimatedSlide(
          duration: Durations.medium1,
          offset: Offset(0, overlayVisible ? 0 : HeightConstants.showOffset),
          curve: Curves.easeInOut,
          child: Container(
            height: HeightConstants.bottomBarHeight,
            color: theme.cardColor,
            child: Column(
              children: [
                Container(
                  height: HeightConstants.progressHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: [0, percentage, percentage, 1],
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primary,
                        theme.colorScheme.secondaryContainer,
                        theme.colorScheme.secondaryContainer,
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: Scaffold.of(context).openDrawer,
                        icon: const Icon(Icons.list),
                        tooltip: 'Chapter list',
                      ),
                      IconButton(
                        onPressed: prevChapter == null ? null : _prev,
                        icon: const Icon(Icons.arrow_back),
                        tooltip: prevChapter?.getSimpleTitle() ?? 'Next',
                      ),
                      IconButton(
                        onPressed: nextChapter == null ? null : _next,
                        icon: const Icon(Icons.arrow_forward),
                        tooltip: nextChapter?.getSimpleTitle() ?? 'Next',
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
