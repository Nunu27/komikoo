import 'package:fpdart/fpdart.dart';
import 'package:komikoo/constants/constants.dart';
import 'package:komikoo/data/repositories/comic_repository.dart';
import 'package:komikoo/domain/models/chapter/chapter.dart';
import 'package:komikoo/domain/models/chapter/chapter_data.dart';
import 'package:komikoo/domain/models/comic/comic.dart';
import 'package:komikoo/domain/models/comic/comic_compact.dart';
import 'package:komikoo/domain/models/core/failure.dart';
import 'package:komikoo/domain/models/core/paginated_data.dart';
import 'package:komikoo/domain/models/feed/feed.dart';
import 'package:komikoo/typedefs.dart';
import 'package:komikoo/utils/cache_for.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'comic_controller.g.dart';

@riverpod
ComicController comicController(ComicControllerRef ref) {
  return ComicController(repository: ref.watch(comicRepositoryProvider));
}

@riverpod
Future<List<Feed>> getFeed(GetFeedRef ref) {
  return ref.watch(comicRepositoryProvider).getFeed();
}

@riverpod
Future<Comic> getDetails(GetDetailsRef ref, String slug) async {
  final result = await ref.watch(comicRepositoryProvider).getDetails(slug);
  ref.cacheFor(Constants.cacheDuration);

  return result;
}

@riverpod
Future<ChapterData> getChapter(GetChapterRef ref, String hid) async {
  final result = await ref.watch(comicRepositoryProvider).getChapter(hid);
  ref.cacheFor(Constants.cacheDuration);

  return result;
}

class ComicController {
  final ComicRepository _repository;

  ComicController({required ComicRepository repository})
      : _repository = repository;

  FutureEither<PaginatedData<Chapter>> getChapters(
    String hid, {
    String? query,
    Language? lang,
    int? order,
    int page = 1,
  }) async {
    try {
      return right(await _repository.getChapters(
        hid,
        page,
        query: query,
        lang: lang,
        order: order,
      ));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<PaginatedData<ComicCompact>> filter(
    Map<String, dynamic> options,
    int page,
  ) async {
    try {
      return right(await _repository.filter(options, page));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
