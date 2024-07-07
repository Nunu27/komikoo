// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:komikoo/presentation/pages/details/details_page.dart' as _i1;
import 'package:komikoo/presentation/pages/explore/explore_page.dart' as _i2;
import 'package:komikoo/presentation/pages/feed/feed_page.dart' as _i4;
import 'package:komikoo/presentation/pages/library/favorites_page.dart' as _i3;
import 'package:komikoo/presentation/pages/library/history_page.dart' as _i5;
import 'package:komikoo/presentation/pages/library/library_page.dart' as _i6;
import 'package:komikoo/presentation/pages/main_page.dart' as _i7;
import 'package:komikoo/presentation/pages/reader/reader_page.dart' as _i8;
import 'package:komikoo/presentation/pages/search/search_page.dart' as _i9;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    DetailsRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.DetailsPage(
          key: args.key,
          slug: args.slug,
        ),
      );
    },
    ExploreRoute.name: (routeData) {
      final args = routeData.argsAs<ExploreRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.ExplorePage(
          key: args.key,
          title: args.title,
          options: args.options,
        ),
      );
    },
    FavoritesRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.FavoritesPage(),
      );
    },
    FeedRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.FeedPage(),
      );
    },
    HistoryRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.HistoryPage(),
      );
    },
    LibraryRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.LibraryPage(),
      );
    },
    MainRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.MainPage(),
      );
    },
    ReaderRoute.name: (routeData) {
      final args = routeData.argsAs<ReaderRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.ReaderPage(
          key: args.key,
          comicSlug: args.comicSlug,
          hid: args.hid,
        ),
      );
    },
    SearchRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.SearchPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.DetailsPage]
class DetailsRoute extends _i10.PageRouteInfo<DetailsRouteArgs> {
  DetailsRoute({
    _i11.Key? key,
    required String slug,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          DetailsRoute.name,
          args: DetailsRouteArgs(
            key: key,
            slug: slug,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailsRoute';

  static const _i10.PageInfo<DetailsRouteArgs> page =
      _i10.PageInfo<DetailsRouteArgs>(name);
}

class DetailsRouteArgs {
  const DetailsRouteArgs({
    this.key,
    required this.slug,
  });

  final _i11.Key? key;

  final String slug;

  @override
  String toString() {
    return 'DetailsRouteArgs{key: $key, slug: $slug}';
  }
}

/// generated route for
/// [_i2.ExplorePage]
class ExploreRoute extends _i10.PageRouteInfo<ExploreRouteArgs> {
  ExploreRoute({
    _i11.Key? key,
    required String title,
    required Map<String, dynamic> options,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          ExploreRoute.name,
          args: ExploreRouteArgs(
            key: key,
            title: title,
            options: options,
          ),
          initialChildren: children,
        );

  static const String name = 'ExploreRoute';

  static const _i10.PageInfo<ExploreRouteArgs> page =
      _i10.PageInfo<ExploreRouteArgs>(name);
}

class ExploreRouteArgs {
  const ExploreRouteArgs({
    this.key,
    required this.title,
    required this.options,
  });

  final _i11.Key? key;

  final String title;

  final Map<String, dynamic> options;

  @override
  String toString() {
    return 'ExploreRouteArgs{key: $key, title: $title, options: $options}';
  }
}

/// generated route for
/// [_i3.FavoritesPage]
class FavoritesRoute extends _i10.PageRouteInfo<void> {
  const FavoritesRoute({List<_i10.PageRouteInfo>? children})
      : super(
          FavoritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoritesRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i4.FeedPage]
class FeedRoute extends _i10.PageRouteInfo<void> {
  const FeedRoute({List<_i10.PageRouteInfo>? children})
      : super(
          FeedRoute.name,
          initialChildren: children,
        );

  static const String name = 'FeedRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i5.HistoryPage]
class HistoryRoute extends _i10.PageRouteInfo<void> {
  const HistoryRoute({List<_i10.PageRouteInfo>? children})
      : super(
          HistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i6.LibraryPage]
class LibraryRoute extends _i10.PageRouteInfo<void> {
  const LibraryRoute({List<_i10.PageRouteInfo>? children})
      : super(
          LibraryRoute.name,
          initialChildren: children,
        );

  static const String name = 'LibraryRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i7.MainPage]
class MainRoute extends _i10.PageRouteInfo<void> {
  const MainRoute({List<_i10.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i8.ReaderPage]
class ReaderRoute extends _i10.PageRouteInfo<ReaderRouteArgs> {
  ReaderRoute({
    _i11.Key? key,
    required String comicSlug,
    required String hid,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          ReaderRoute.name,
          args: ReaderRouteArgs(
            key: key,
            comicSlug: comicSlug,
            hid: hid,
          ),
          initialChildren: children,
        );

  static const String name = 'ReaderRoute';

  static const _i10.PageInfo<ReaderRouteArgs> page =
      _i10.PageInfo<ReaderRouteArgs>(name);
}

class ReaderRouteArgs {
  const ReaderRouteArgs({
    this.key,
    required this.comicSlug,
    required this.hid,
  });

  final _i11.Key? key;

  final String comicSlug;

  final String hid;

  @override
  String toString() {
    return 'ReaderRouteArgs{key: $key, comicSlug: $comicSlug, hid: $hid}';
  }
}

/// generated route for
/// [_i9.SearchPage]
class SearchRoute extends _i10.PageRouteInfo<void> {
  const SearchRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}
