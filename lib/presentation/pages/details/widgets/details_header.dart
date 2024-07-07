import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:komikoo/domain/models/comic/comic.dart';
import 'package:komikoo/presentation/widgets/cover/cover_image_with_ratio.dart';
import 'package:komikoo/presentation/pages/details/widgets/header_info.dart';

class DetailsHeader extends StatelessWidget {
  final Comic comic;
  final bool isFavorite;
  final VoidCallback toggleFavorite;
  final void Function(Comic, String) openChapter;

  const DetailsHeader({
    super.key,
    required this.comic,
    required this.isFavorite,
    required this.toggleFavorite,
    required this.openChapter,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        if (comic.cover != null)
          CachedNetworkImage(
            imageUrl: comic.cover!,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const SizedBox(),
          ),
        Positioned.fill(
          bottom: -1,
          child: Container(
            padding: const EdgeInsets.all(14).copyWith(top: 100),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  theme.colorScheme.background.withOpacity(0.6),
                  theme.colorScheme.background.withOpacity(0.9),
                  theme.colorScheme.background,
                ],
              ),
            ),
            child: Row(
              children: [
                CoverImageWithRatio(cover: comic.cover),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 3.5),
                          if (comic.native != null)
                            Text(
                              comic.native!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium!.copyWith(
                                color: theme.colorScheme.onBackground
                                    .withOpacity(0.8),
                              ),
                            ),
                          Text(
                            comic.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 3.5),
                          Row(
                            children: [
                              HeaderInfo(
                                icon: comic.status.icon,
                                text: comic.status.label,
                              ),
                              const Text(' • '),
                              HeaderInfo(
                                icon: Icons.star,
                                text: comic.rating ?? 'N/A',
                              ),
                              Text(' • ${comic.year}'),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          OutlinedButton.icon(
                            onPressed: comic.firstChapter == null
                                ? null
                                : () => openChapter(
                                      comic,
                                      comic.firstChapter!.hid,
                                    ),
                            style: OutlinedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              backgroundColor:
                                  theme.colorScheme.primaryContainer,
                              foregroundColor:
                                  theme.colorScheme.onPrimaryContainer,
                              side: BorderSide(
                                color: theme.colorScheme.outlineVariant,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            icon: const Icon(Icons.import_contacts),
                            label: Text(
                              comic.firstChapter?.getSimpleTitle() ?? 'Read',
                            ),
                          ),
                          const SizedBox(width: 3.5),
                          OutlinedButton(
                            onPressed: toggleFavorite,
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              foregroundColor: isFavorite
                                  ? Colors.red
                                  : theme.colorScheme.onBackground,
                              side: BorderSide(
                                color: theme.colorScheme.outlineVariant,
                              ),
                              minimumSize: const Size(40, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
