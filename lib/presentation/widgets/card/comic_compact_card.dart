import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:komikoo/domain/models/comic/comic_compact.dart';
import 'package:komikoo/router/app_router.gr.dart';
import 'package:komikoo/presentation/widgets/cover/cover_image.dart';

class ComicCompactCard extends StatelessWidget {
  final ComicCompact data;

  const ComicCompactCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => context.pushRoute(DetailsRoute(slug: data.slug)),
      child: Padding(
        padding: const EdgeInsets.all(3.5),
        child: Stack(
          children: [
            Positioned.fill(
              child: CoverImage(cover: data.cover),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(7).copyWith(top: 50),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(4),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      theme.colorScheme.background.withOpacity(0),
                      theme.colorScheme.background.withOpacity(0.8)
                    ],
                  ),
                ),
                child: Text(
                  data.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
