class ChapterContent {
  final String url;
  final int h;
  final int w;

  ChapterContent({
    required this.url,
    required this.h,
    required this.w,
  });

  factory ChapterContent.fromMap(Map<String, dynamic> map) {
    return ChapterContent(
      url: map['url'] as String,
      h: map['h'] as int,
      w: map['w'] as int,
    );
  }

  @override
  String toString() => 'ImageData(url: $url, h: $h, w: $w)';

  @override
  bool operator ==(covariant ChapterContent other) {
    if (identical(this, other)) return true;

    return other.url == url && other.h == h && other.w == w;
  }

  @override
  int get hashCode => url.hashCode ^ h.hashCode ^ w.hashCode;
}
