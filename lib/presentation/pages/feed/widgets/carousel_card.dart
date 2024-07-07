import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:komikoo/domain/models/feed/carousel_item.dart';
import 'package:komikoo/presentation/widgets/cover/cover_image_with_ratio.dart';
import 'package:komikoo/router/app_router.gr.dart';

class CarouselCard extends StatelessWidget {
  final CarouselItem data;

  const CarouselCard({super.key, required this.data});

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
        onTap: () => context.pushRoute(DetailsRoute(slug: data.slug)),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              CoverImageWithRatio(cover: data.cover),
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
                    Text('${data.status.label} • Chapter ${data.lastChapter}'),
                    const SizedBox(height: 4),
                    Expanded(
                      child: Text(
                        data.desc ?? 'No description',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
