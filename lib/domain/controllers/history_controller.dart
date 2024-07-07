import 'package:bot_toast/bot_toast.dart';
import 'package:komikoo/data/database/database.dart';
import 'package:komikoo/domain/models/chapter/chapter.dart';
import 'package:komikoo/domain/models/comic/comic.dart';
import 'package:komikoo/domain/models/comic/comic_with_progress.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_controller.g.dart';

@riverpod
HistoryController historyController(HistoryControllerRef ref) {
  return HistoryController(database: ref.watch(databaseProvider));
}

@riverpod
Stream<List<ComicWithProgress>> historyList(HistoryListRef ref,
    {int? limit, bool? completed}) {
  return ref.watch(databaseProvider).historyDao.historyList(
        limit: limit,
        completed: completed,
      );
}

class HistoryController {
  final Database _database;

  HistoryController({required Database database}) : _database = database;

  void clearHistory() async {
    final result = await _database.historyDao.clearHistory();

    BotToast.showText(
      text: result.fold(
        (l) => 'Failed to update comic data',
        (r) => 'History cleared',
      ),
    );
  }

  void deleteHistory(String hid) async {
    final result = await _database.historyDao.deleteHistory(hid);

    result.fold(
      (l) => BotToast.showText(text: 'Failed to delete history'),
      (r) => null,
    );
  }

  void updateComicEntry(Comic comic) async {
    final result = await _database.historyDao.updateComicEntry(comic);

    result.fold(
      (l) => BotToast.showText(text: 'Failed to update comic data'),
      (r) => null,
    );
  }

  void updateProgress({
    required Chapter chapter,
    required String comicSlug,
    required double progress,
  }) async {
    final result = await _database.historyDao.updateProgress(
      hid: chapter.hid,
      title: chapter.getSimpleTitle(),
      comicSlug: comicSlug,
      progress: progress,
    );

    result.fold(
      (l) => BotToast.showText(text: 'Failed to save reading progress'),
      (r) => null,
    );
  }
}
