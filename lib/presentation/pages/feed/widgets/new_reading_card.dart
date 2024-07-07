import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:komikoo/constants/height_constants.dart';
import 'package:komikoo/domain/models/comic/comic_with_progress.dart';
import 'package:komikoo/presentation/widgets/cover/cover_image_with_ratio.dart';
import 'package:komikoo/router/app_router.gr.dart';
import 'package:komikoo/utils/formatter.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewReadingCard extends StatelessWidget {
  final ComicWithProgress data;

  const NewReadingCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      child: InkWell(
        onTap: () => context.pushRoute(ReaderRoute(
          comicSlug: data.slug,
          hid: data.chapterHid,
        )),
        child: Container(
          decoration: BoxDecoration(
            image: data.cover == null
                ? null
                : DecorationImage(
                    image: CachedNetworkImageProvider(data.cover!),
                    fit: BoxFit.cover,
                  ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.5),
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            boxShadow: kElevationToShadow[2],
                          ),
                          child: CoverImageWithRatio(cover: data.cover),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  data.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleLarge,
                                ),
                              ),
                              Text(
                                '${data.chapterTitle} • ${data.progress.toPercentage()}%',
                              ),
                              Text(timeago.format(data.date))
                            ],
                          ),
                        ),
                      ],
                    ),
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
        ),
      ),
    );
  }
}
