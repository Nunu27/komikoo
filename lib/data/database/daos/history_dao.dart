import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:komikoo/constants/constants.dart';
import 'package:komikoo/data/database/database.dart';
import 'package:komikoo/data/database/tables/comics.dart';
import 'package:komikoo/data/database/tables/reading_progresses.dart';
import 'package:komikoo/domain/models/comic/comic.dart';
import 'package:komikoo/domain/models/comic/comic_with_progress.dart';
import 'package:komikoo/domain/models/core/failure.dart';
import 'package:komikoo/typedefs.dart';

part 'history_dao.g.dart';

@DriftAccessor(tables: [Comics, ReadingProgresses])
class HistoryDao extends DatabaseAccessor<Database> with _$HistoryDaoMixin {
  HistoryDao(super.db);

  Stream<List<ComicWithProgress>> historyList({int? limit, bool? completed}) {
    JoinedSelectStatement query = select(readingProgresses).join(
      [
        innerJoin(
          comics,
          comics.slug.equalsExp(readingProgresses.comicSlug),
        ),
      ],
    )..groupBy(
        [readingProgresses.comicSlug],
        having: readingProgresses.date.equalsExp(readingProgresses.date.max()),
      );
    if (completed != null) {
      query.where(
        completed
            ? readingProgresses.progress
                .isBiggerOrEqualValue(Constants.progressThreshold)
            : readingProgresses.progress
                .isSmallerThanValue(Constants.progressThreshold),
      );
    }
    query.orderBy([OrderingTerm.desc(readingProgresses.date)]);
    if (limit != null) query.limit(limit);

    return query
        .map(
          (row) => ComicWithProgress.fromEntity(
            row.readTable(comics),
            row.readTable(readingProgresses),
          ),
        )
        .watch();
  }

  FutureVoid clearHistory() async {
    try {
      await delete(readingProgresses).go();
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid deleteHistory(String hid) async {
    try {
      final query = delete(readingProgresses)
        ..where((tbl) => tbl.hid.equals(hid));
      await query.go();
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid updateComicEntry(Comic comic) async {
    try {
      await into(comics).insertOnConflictUpdate(
        ComicsCompanion(
          slug: Value(comic.slug),
          cover: Value(comic.cover),
          title: Value(comic.title),
        ),
      );

      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<double?> getProgress(String hid) async {
    try {
      final query = select(readingProgresses)..where((t) => t.hid.equals(hid));
      return right(await query.map((row) => row.progress).getSingleOrNull());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid updateProgress({
    required String hid,
    required String title,
    required String comicSlug,
    required double progress,
  }) async {
    try {
      await into(readingProgresses).insertOnConflictUpdate(
        ReadingProgressesCompanion(
          hid: Value(hid),
          title: Value(title),
          comicSlug: Value(comicSlug),
          progress: Value(progress),
          date: Value(DateTime.now()),
        ),
      );

      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
