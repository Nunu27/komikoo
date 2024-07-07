import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:komikoo/constants/height_constants.dart';
import 'package:komikoo/domain/models/comic/comic_with_progress.dart';
import 'package:komikoo/presentation/widgets/cover/cover_image_with_ratio.dart';
import 'package:komikoo/router/app_router.gr.dart';

class ReadingCard extends StatelessWidget {
  final ComicWithProgress data;
  final double width;

  const ReadingCard({super.key, required this.data, required this.width});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: width,
      child: InkWell(
        onTap: () => context.pushRoute(ReaderRoute(
          comicSlug: data.slug,
          hid: data.chapterHid,
        )),
        child: Padding(
          padding: const EdgeInsets.all(3.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CoverImageWithRatio(cover: data.cover),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            theme.colorScheme.background.withOpacity(0.1),
                            theme.colorScheme.background.withOpacity(0),
                            theme.colorScheme.background.withOpacity(0.8)
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(7),
                            child: Text(
                              data.chapterTitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelMedium,
                            ),
                          ),
                          Container(
                            height: HeightConstants.progressHeight,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                stops: [0, data.progress, data.progress, 1],
                                colors: [
                                  theme.colorScheme.primary,
                                  theme.colorScheme.primary,
                                  theme.colorScheme.secondaryContainer,
                                  theme.colorScheme.secondaryContainer,
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Text(
                data.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
