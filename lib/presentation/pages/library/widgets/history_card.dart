import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:komikoo/constants/height_constants.dart';
import 'package:komikoo/domain/models/comic/comic_with_progress.dart';
import 'package:komikoo/presentation/widgets/cover/cover_image_with_ratio.dart';
import 'package:komikoo/router/app_router.gr.dart';
import 'package:komikoo/utils/formatter.dart';

class HistoryCard extends StatelessWidget {
  final ComicWithProgress data;
  final void Function(String hid) onDelete;

  const HistoryCard({super.key, required this.data, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        context.pushRoute(DetailsRoute(slug: data.slug));
      },
      child: Container(
        height: HeightConstants.historyCardHeight,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        child: Row(
          children: [
            CoverImageWithRatio(cover: data.cover),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium,
                  ),
                  Text('${data.chapterTitle} • ${data.date.toTimeString()}'),
                ],
              ),
            ),
            IconButton(
              onPressed: () => onDelete(data.chapterHid),
              icon: const Icon(Icons.delete_outline),
            ),
            IconButton(
              onPressed: () {
                context.pushRoute(ReaderRoute(
                  comicSlug: data.slug,
                  hid: data.chapterHid,
                ));
              },
              icon: const Icon(Icons.play_arrow),
            ),
          ],
        ),
      ),
    );
  }
}
