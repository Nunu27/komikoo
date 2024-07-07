import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:komikoo/data/database/database.dart';
import 'package:komikoo/data/database/tables/comics.dart';
import 'package:komikoo/domain/models/comic/comic.dart';
import 'package:komikoo/domain/models/comic/comic_compact.dart';
import 'package:komikoo/domain/models/core/failure.dart';
import 'package:komikoo/typedefs.dart';

part 'favorite_dao.g.dart';

@DriftAccessor(tables: [Comics])
class FavoriteDao extends DatabaseAccessor<Database> with _$FavoriteDaoMixin {
  FavoriteDao(super.db);

  Stream<List<ComicCompact>> favoritesComic() {
    final query = select(comics)..where((t) => t.isFavorite.equals(true));
    return query.map((row) => ComicCompact.fromEntity(row)).watch();
  }

  Stream<bool> isFavorite(String slug) {
    final query = comics.count(
      where: (t) => t.slug.equals(slug) & t.isFavorite.equals(true),
    );
    return query.map((count) => count == 1).watchSingle();
  }

  FutureVoid addToFavorite(Comic comic) async {
    try {
      await into(comics).insertOnConflictUpdate(
        ComicsCompanion(
          slug: Value(comic.slug),
          cover: Value(comic.cover),
          title: Value(comic.title),
          isFavorite: const Value(true),
        ),
      );

      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid clearFavorites() async {
    try {
      await (update(comics)..where((t) => t.isFavorite.equals(true)))
          .write(const ComicsCompanion(isFavorite: Value(false)));
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid removeFromFavorite(String slug) async {
    try {
      await (update(comics)..where((t) => t.slug.equals(slug))).write(
        const ComicsCompanion(
          isFavorite: Value(false),
        ),
      );

      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
