import 'package:drift/drift.dart';
import 'package:komikoo/data/database/tables/comics.dart';

@TableIndex(name: 'comic_progresses', columns: {#comicSlug, #progress})
@TableIndex(name: 'progresses_date', columns: {#date})
@DataClassName('ReadingProgressEntity')
class ReadingProgresses extends Table {
  TextColumn get hid => text()();
  TextColumn get title => text()();
  TextColumn get comicSlug => text().references(
        Comics,
        #slug,
        onDelete: KeyAction.cascade,
        onUpdate: KeyAction.cascade,
      )();
  RealColumn get progress => real()();
  DateTimeColumn get date => dateTime()();

  @override
  Set<Column> get primaryKey => {hid};
}
