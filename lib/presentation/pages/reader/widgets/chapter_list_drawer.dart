import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:komikoo/constants/height_constants.dart';
import 'package:komikoo/domain/models/chapter/chapter.dart';
import 'package:komikoo/presentation/pages/reader/widgets/chapter_list_item_compact.dart';
import 'package:komikoo/presentation/widgets/loader.dart';

class ChapterListDrawer extends StatefulWidget {
  final int? currentIndex;
  final List<Chapter>? chapterList;
  final void Function(int index) onTap;
  final void Function(bool opened) onState;

  const ChapterListDrawer({
    super.key,
    required this.currentIndex,
    required this.chapterList,
    required this.onTap,
    required this.onState,
  });

  @override
  State<ChapterListDrawer> createState() => _ChapterListDrawerState();
}

class _ChapterListDrawerState extends State<ChapterListDrawer> {
  final _controller = ScrollController();
  late final Timer? _runner;

  List<Chapter>? searchResults;

  @override
  void initState() {
    super.initState();
    widget.onState(true);
    if (widget.currentIndex == null) {
      _runner == null;
    } else {
      _runner = Timer(Durations.short3, () {
        _controller.jumpTo(min(
          _controller.position.maxScrollExtent,
          widget.currentIndex! * HeightConstants.chapterTileCompactHeight,
        ));
      });
    }
  }

  @override
  void dispose() {
    if (_runner?.isActive ?? false) _runner!.cancel();
    widget.onState(false);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverAppBar(
          pinned: true,
          title: const Text('Chapters'),
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        widget.currentIndex == null
            ? const SliverFillRemaining(
                hasScrollBody: false,
                child: Loader(),
              )
            : SliverList.builder(
                itemCount: widget.chapterList!.length,
                itemBuilder: (context, index) => ChapterListItemCompact(
                  isActive: index == widget.currentIndex,
                  chapter: widget.chapterList![index],
                  onTap: widget.onTap,
                ),
              ),
      ],
    );
  }
}
