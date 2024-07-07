import 'package:komikoo/domain/models/comic/comic.dart';

class ListItem {
  final String slug;
  final String? cover;
  final String title;
  final ComicType? type;
  final String? lastChapter;

  ListItem({
    required this.slug,
    required this.cover,
    required this.title,
    required this.type,
    required this.lastChapter,
  });

  ListItem copyWith({
    String? slug,
    String? cover,
    String? title,
    ComicType? type,
    String? lastChapter,
  }) {
    return ListItem(
      slug: slug ?? this.slug,
      cover: cover ?? this.cover,
      title: title ?? this.title,
      type: type ?? this.type,
      lastChapter: lastChapter ?? this.lastChapter,
    );
  }

  factory ListItem.fromMap(Map<String, dynamic> map) {
    final cover = map['cover_url'];
    final key =
        ((map['md_covers'] as List).elementAtOrNull(0)?['b2key'] as String?)
            ?.split('.')
            .first;

    return ListItem(
      slug: map['slug'],
      cover: cover ?? key == null
          ? null
          : 'https://meo.comick.pictures/$key-s.jpg',
      title: map['title'],
      type: map['country'] == null
          ? ComicType.others
          : ComicType.values.byName(map['country']),
      lastChapter: 'Chapter ${map['last_chapter']}',
    );
  }

  @override
  String toString() {
    return 'ListItem(slug: $slug, cover: $cover, title: $title, type: $type, lastChapter: $lastChapter)';
  }

  @override
  bool operator ==(covariant ListItem other) {
    if (identical(this, other)) return true;

    return other.slug == slug &&
        other.cover == cover &&
        other.title == title &&
        other.type == type &&
        other.lastChapter == lastChapter;
  }

  @override
  int get hashCode {
    return slug.hashCode ^
        cover.hashCode ^
        title.hashCode ^
        type.hashCode ^
        lastChapter.hashCode;
  }
}
