import 'package:drift/drift.dart';
import 'package:komikoo/data/database/connection.dart';
import 'package:komikoo/data/database/daos/favorite_dao.dart';
import 'package:komikoo/data/database/daos/history_dao.dart';
import 'package:komikoo/data/database/tables/comics.dart';
import 'package:komikoo/data/database/tables/reading_progresses.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database.g.dart';

@riverpod
Database database(DatabaseRef ref) {
  return Database();
}

@DriftDatabase(
  tables: [Comics, ReadingProgresses],
  daos: [FavoriteDao, HistoryDao],
)
class Database extends _$Database {
  Database() : super(openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.addColumn(readingProgresses, readingProgresses.title);
        }
      },
    );
  }
}
