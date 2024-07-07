import 'package:drift/drift.dart';

@TableIndex(name: 'comic_favorites', columns: {#isFavorite})
@DataClassName('ComicCompactEntity')
class Comics extends Table {
  TextColumn get slug => text()();
  TextColumn get cover => text().nullable()();
  TextColumn get title => text()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {slug};
}
