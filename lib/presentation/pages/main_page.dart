import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:komikoo/router/app_router.gr.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        FeedRoute(),
        FavoritesRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) => NavigationBar(
        selectedIndex: tabsRouter.activeIndex,
        onDestinationSelected: tabsRouter.setActiveIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_outlined),
            selectedIcon: Icon(Icons.book),
            label: 'Library',
          ),
        ],
      ),
    );
  }
}
