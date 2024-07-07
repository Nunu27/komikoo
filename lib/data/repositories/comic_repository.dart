import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:komikoo/constants/constants.dart';
import 'package:komikoo/domain/models/chapter/chapter.dart';
import 'package:komikoo/domain/models/chapter/chapter_data.dart';
import 'package:komikoo/domain/models/comic/comic_compact.dart';
import 'package:komikoo/domain/models/core/paginated_data.dart';
import 'package:komikoo/domain/models/feed/carousel_item.dart';
import 'package:komikoo/domain/models/comic/comic.dart';
import 'package:komikoo/domain/models/feed/list_item.dart';
import 'package:komikoo/domain/models/core/failure.dart';
import 'package:komikoo/domain/models/feed/carousel_feed.dart';
import 'package:komikoo/domain/models/feed/feed.dart';
import 'package:komikoo/domain/models/feed/list_feed.dart';
import 'package:komikoo/domain/models/feed/reading_feed.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'comic_repository.g.dart';

@riverpod
ComicRepository comicRepository(ComicRepositoryRef ref) {
  return ComicRepository();
}

class ComicRepository {
  Future<List<Feed>> getFeed() async {
    final response = await _handleRequest(http.get(_getUrl('top')));

    return [
      CarouselFeed(
        items: (response['comicsByCurrentSeason']['data'] as List)
            .take(5)
            .map((e) => CarouselItem.fromMap(e))
            .toList(),
      ),
      ReadingFeed(),
      ListFeed(
        title: 'Recently added',
        items: (response['news'] as List)
            .map(
              (e) => ListItem.fromMap(e),
            )
            .toList(),
        more: {'sort': 'created_at'},
      ),
      ListFeed(
        title: 'Completed comics',
        items: (response['completions'] as List)
            .map(
              (e) => ListItem.fromMap(e),
            )
            .toList(),
        more: {'sort': 'uploaded', 'status': '2'},
      ),
    ];
  }

  Future<Comic> getDetails(String slug) async {
    final response = await _handleRequest(
      http.get(_getUrl('comic/$slug', {'tachiyomi': 'true'})),
    );

    return Comic.fromMap(response);
  }

  Future<PaginatedData<Chapter>> getChapters(
    String hid,
    int page, {
    String? query,
    Language? lang,
    int? order,
  }) async {
    final response = await _handleRequest(
      http.get(_getUrl('comic/$hid/chapters', {
        'limit': Constants.chapterPerPage,
        'chap': query,
        'lang': lang?.langCode,
        'chap-order': order,
        'page': page,
      })),
    );

    final items = (response['chapters'] as List)
        .mapWithIndex((t, index) => Chapter.fromMap(t))
        .toList();

    return PaginatedData(
      total: response['total'],
      current: page,
      haveNext: items.length == Constants.chapterPerPage,
      items: items,
    );
  }

  Future<ChapterData> getChapter(String hid) async {
    final response = await _handleRequest(
      http.get(_getUrl('chapter/$hid', {'tachiyomi': 'true'})),
    );

    return ChapterData.fromMap(response);
  }

  Future<PaginatedData<ComicCompact>> filter(
    Map<String, dynamic> options,
    int page,
  ) async {
    final response = await _handleRequest(
      http.get(_getUrl('v1.0/search', {
        ...options,
        'tachiyomi': 'true',
        'limit': Constants.comicPerPage,
        'page': page,
      })),
    ) as List;

    return PaginatedData(
      total: null,
      current: page,
      haveNext: response.length == Constants.comicPerPage,
      items: response.map((e) => ComicCompact.fromMap(e)).toList(),
    );
  }

  Uri _getUrl(String path, [Map<String, dynamic>? params]) => Uri.https(
        Constants.apiHost,
        path,
        (params?..removeWhere((key, value) => value == null))
            ?.map((key, value) => MapEntry(key, value.toString())),
      );
  Future<dynamic> _handleRequest(Future<http.Response> request) async {
    try {
      final response = await request;

      if (!response.headers['content-type']!.startsWith('application/json')) {
        throw Failure('Invalid response');
      }

      final data = jsonDecode(response.body);

      if (data is Map && data['message'] != null) {
        throw Failure(data['message']);
      } else {
        return data;
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
