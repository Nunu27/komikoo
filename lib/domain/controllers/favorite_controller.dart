import 'package:bot_toast/bot_toast.dart';
import 'package:komikoo/data/database/database.dart';
import 'package:komikoo/domain/models/comic/comic.dart';
import 'package:komikoo/domain/models/comic/comic_compact.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_controller.g.dart';

@riverpod
FavoriteController favoriteController(FavoriteControllerRef ref) {
  return FavoriteController(database: ref.watch(databaseProvider));
}

@riverpod
Stream<List<ComicCompact>> favoritesComic(FavoritesComicRef ref) {
  return ref.watch(databaseProvider).favoriteDao.favoritesComic();
}

@riverpod
Stream<bool> isFavorite(IsFavoriteRef ref, String slug) {
  return ref.watch(databaseProvider).favoriteDao.isFavorite(slug);
}

class FavoriteController {
  final Database _database;

  FavoriteController({required Database database}) : _database = database;

  void addToFavorite(Comic comic) async {
    final res = await _database.favoriteDao.addToFavorite(comic);

    BotToast.showText(
      text: res.fold(
        (l) => l.message,
        (r) => 'Added to favorite',
      ),
    );
  }

  void clearFavorites() async {
    final res = await _database.favoriteDao.clearFavorites();

    BotToast.showText(
      text: res.fold(
        (l) => l.message,
        (r) => 'Favorites cleared',
      ),
    );
  }

  void removeFromFavorite(String slug) async {
    final res = await _database.favoriteDao.removeFromFavorite(slug);

    BotToast.showText(
      text: res.fold(
        (l) => l.message,
        (r) => 'Removed from favorite',
      ),
    );
  }
}
