import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:komikoo/presentation/widgets/loading_shimmer.dart';

class CoverImage extends StatelessWidget {
  final String? cover;

  const CoverImage({
    super.key,
    required this.cover,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: theme.colorScheme.onBackground.withOpacity(0.05),
      ),
      child: cover == null
          ? _errorView(theme)
          : CachedNetworkImage(
              imageUrl: cover!,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => _errorView(theme),
              placeholder: (context, url) => const LoadingShimmer(),
            ),
    );
  }

  Container _errorView(ThemeData theme) {
    return Container(
      color: theme.colorScheme.onBackground.withOpacity(0.05),
      child: Icon(
        Icons.broken_image_outlined,
        size: 36,
        color: theme.colorScheme.onBackground.withOpacity(0.5),
      ),
    );
  }
}
