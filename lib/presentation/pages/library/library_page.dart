import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:komikoo/domain/controllers/favorite_controller.dart';
import 'package:komikoo/domain/controllers/history_controller.dart';
import 'package:komikoo/router/app_router.gr.dart';
import 'package:komikoo/utils/utils.dart';

@RoutePage()
class LibraryPage extends ConsumerStatefulWidget {
  const LibraryPage({super.key});

  @override
  ConsumerState<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends ConsumerState<LibraryPage> {
  late final historyActions = [
    IconButton(
      onPressed: _clearHistory,
      icon: const Icon(Icons.delete_sweep_outlined),
    ),
  ];
  late final favoriteActions = [
    IconButton(
      onPressed: _clearFavorites,
      icon: const Icon(Icons.delete_sweep_outlined),
    ),
  ];

  void _clearHistory() async {
    if (await showConfirmationDialog(
      context: context,
      title: 'Delete history',
      content: 'Are you sure? All history will be lost.',
    )) {
      ref.read(historyControllerProvider).clearHistory();
    }
  }

  void _clearFavorites() async {
    if (await showConfirmationDialog(
      context: context,
      title: 'Clear favorites',
      content: 'Are you sure? All favorites will be lost.',
    )) {
      ref.read(favoriteControllerProvider).clearFavorites();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      physics: const NeverScrollableScrollPhysics(),
      routes: const [
        HistoryRoute(),
        FavoritesRoute(),
      ],
      builder: (context, child, controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Library'),
            actions: controller.index == 0 ? historyActions : favoriteActions,
            bottom: TabBar(
              controller: controller,
              tabs: const [
                Tab(text: 'History'),
                Tab(text: 'Favorites'),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}
