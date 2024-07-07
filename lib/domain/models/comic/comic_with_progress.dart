import 'package:komikoo/data/database/database.dart';
import 'package:komikoo/domain/models/comic/comic.dart';
import 'package:komikoo/domain/models/feed/list_item.dart';

class ComicWithProgress {
  final String slug;
  final String? cover;
  final String title;
  final double progress;
  final String chapterTitle;
  final String chapterHid;
  final DateTime date;

  ComicWithProgress({
    required this.slug,
    required this.cover,
    required this.title,
    required this.progress,
    required this.chapterTitle,
    required this.chapterHid,
    required this.date,
  });

  factory ComicWithProgress.fromEntity(
    ComicCompactEntity comicCompactEntity,
    ReadingProgressEntity readingProgressEntity,
  ) {
    return ComicWithProgress(
      slug: comicCompactEntity.slug,
      cover: comicCompactEntity.cover,
      title: comicCompactEntity.title,
      progress: readingProgressEntity.progress,
      chapterTitle: readingProgressEntity.title,
      chapterHid: readingProgressEntity.hid,
      date: readingProgressEntity.date,
    );
  }
  ListItem toListItem() {
    return ListItem(
      slug: slug,
      cover: cover,
      title: title,
      type: ComicType.others,
      lastChapter: chapterTitle,
    );
  }
}
