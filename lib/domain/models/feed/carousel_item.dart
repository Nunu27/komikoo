import 'package:komikoo/domain/models/comic/comic.dart';

class CarouselItem {
  final String slug;
  final String? cover;
  final String title;
  final String? desc;
  final ComicStatus status;
  final String lastChapter;

  CarouselItem({
    required this.slug,
    required this.cover,
    required this.title,
    required this.desc,
    required this.status,
    required this.lastChapter,
  });

  CarouselItem copyWith({
    String? slug,
    String? cover,
    String? title,
    String? desc,
    ComicStatus? status,
    String? lastChapter,
  }) {
    return CarouselItem(
      slug: slug ?? this.slug,
      cover: cover ?? this.cover,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      status: status ?? this.status,
      lastChapter: lastChapter ?? this.lastChapter,
    );
  }

  factory CarouselItem.fromMap(Map<String, dynamic> map) {
    final key =
        ((map['md_covers'] as List).elementAtOrNull(0)?['b2key'] as String?)
            ?.split('.')
            .first;

    return CarouselItem(
      slug: map['slug'] as String,
      cover: key == null ? null : 'https://meo.comick.pictures/$key-s.jpg',
      title: map['title'] as String,
      desc: map['desc'] != null ? map['desc'] as String : null,
      status: ComicStatus.values[map['status'] - 1],
      lastChapter: map['last_chapter'].toString(),
    );
  }

  @override
  String toString() {
    return 'CarouselItem(slug: $slug, cover: $cover, title: $title, desc: $desc, status: $status, lastChapter: $lastChapter)';
  }

  @override
  bool operator ==(covariant CarouselItem other) {
    if (identical(this, other)) return true;

    return other.slug == slug &&
        other.cover == cover &&
        other.title == title &&
        other.desc == desc &&
        other.status == status &&
        other.lastChapter == lastChapter;
  }

  @override
  int get hashCode {
    return slug.hashCode ^
        cover.hashCode ^
        title.hashCode ^
        desc.hashCode ^
        status.hashCode ^
        lastChapter.hashCode;
  }
}
