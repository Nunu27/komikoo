import 'package:auto_route/auto_route.dart';
import 'package:komikoo/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          initial: true,
          page: MainRoute.page,
          transitionsBuilder: TransitionsBuilders.noTransition,
          children: [
            AutoRoute(page: FeedRoute.page),
            AutoRoute(
              page: LibraryRoute.page,
              children: [
                AutoRoute(page: HistoryRoute.page),
                AutoRoute(page: FavoritesRoute.page),
              ],
            ),
          ],
        ),
        AutoRoute(page: ExploreRoute.page),
        CustomRoute(
          page: SearchRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        AutoRoute(page: DetailsRoute.page),
        AutoRoute(page: ReaderRoute.page),
      ];
}
