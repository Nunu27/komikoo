import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:komikoo/domain/models/chapter/chapter.dart';
import 'package:komikoo/domain/models/chapter/chapter_content.dart';
import 'package:komikoo/domain/models/comic/comic_compact.dart';

class ChapterData {
  final int currentIndex;
  final int totalHeight;
  final List<ChapterContent> contents;
  final List<Chapter> chapterList;
  final ComicCompact comic;

  ChapterData({
    required this.currentIndex,
    required this.totalHeight,
    required this.contents,
    required this.chapterList,
    required this.comic,
  });

  factory ChapterData.fromMap(Map<String, dynamic> map) {
    final chapter = map['chapter'];

    int totalHeight = 0;
    final contents = List<ChapterContent>.from(
      (chapter['images'] as List).map<ChapterContent>(
        (x) {
          final content = ChapterContent.fromMap(x as Map<String, dynamic>);
          totalHeight += content.h;

          return content;
        },
      ),
    );
    final currentChapter = Chapter.fromMap(chapter);
    final chapterList = List<Chapter>.from(
      (map['chapters'] as List).mapWithIndex<Chapter>(
        (e, index) => Chapter.fromMap(e, index: index),
      ),
    );

    return ChapterData(
      currentIndex: chapterList.indexOf(currentChapter),
      totalHeight: totalHeight,
      contents: contents,
      chapterList: chapterList,
      comic: ComicCompact.fromMap(chapter['md_comics']),
    );
  }

  @override
  String toString() {
    return 'ChapterData(currentIndex: $currentIndex, totalHeight: $totalHeight, content: $contents, chapterList: $chapterList, comic: $comic)';
  }

  @override
  bool operator ==(covariant ChapterData other) {
    if (identical(this, other)) return true;

    return other.currentIndex == currentIndex &&
        other.totalHeight == totalHeight &&
        listEquals(other.contents, contents) &&
        listEquals(other.chapterList, chapterList) &&
        other.comic == comic;
  }

  @override
  int get hashCode {
    return currentIndex.hashCode ^
        totalHeight.hashCode ^
        contents.hashCode ^
        chapterList.hashCode ^
        comic.hashCode;
  }
}
