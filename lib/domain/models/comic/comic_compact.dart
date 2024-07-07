import 'package:komikoo/data/database/database.dart';

class ComicCompact {
  final String slug;
  final String? cover;
  final String title;
  final String? info;

  ComicCompact({
    required this.slug,
    required this.cover,
    required this.title,
    this.info,
  });

  factory ComicCompact.fromMap(Map<String, dynamic> map) {
    return ComicCompact(
      slug: map['slug'],
      cover: map['cover_url'],
      title: map['title'],
      info:
          map['last_chapter'] == null ? null : 'Chapter ${map['last_chapter']}',
    );
  }

  factory ComicCompact.fromEntity(ComicCompactEntity entity) {
    return ComicCompact(
      slug: entity.slug,
      cover: entity.cover,
      title: entity.title,
    );
  }

  @override
  bool operator ==(covariant ComicCompact other) {
    if (identical(this, other)) return true;

    return other.slug == slug;
  }

  @override
  int get hashCode {
    return slug.hashCode;
  }
}
