import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:komikoo/constants/height_constants.dart';
import 'package:komikoo/domain/controllers/favorite_controller.dart';
import 'package:komikoo/presentation/widgets/card/comic_compact_card.dart';
import 'package:komikoo/presentation/widgets/error_view.dart';
import 'package:komikoo/presentation/widgets/loader.dart';

@RoutePage()
class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(favoritesComicProvider).when(
          data: (favorites) {
            if (favorites.isEmpty) {
              return const ErrorView(message: 'Still empty');
            }

            return GridView.builder(
              itemCount: favorites.length,
              padding: const EdgeInsets.all(10.5),
              physics: const ClampingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: HeightConstants.coverRatio,
              ),
              itemBuilder: (context, index) => ComicCompactCard(
                data: favorites[index],
              ),
            );
          },
          error: (error, stackTrace) => ErrorView(
            message: error.toString(),
            onRetry: () => ref.invalidate(favoritesComicProvider),
          ),
          loading: () => const Loader(),
        );
  }
}
