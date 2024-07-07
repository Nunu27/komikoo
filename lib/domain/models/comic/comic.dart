import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:komikoo/domain/models/chapter/chapter.dart';

enum ComicType {
  jp('Manga', FlagsCode.JP),
  kr('Manhwa', FlagsCode.KR),
  cn('Manhua', FlagsCode.CN),
  others('Others');

  static ComicType fromCode(String code) {
    try {
      return ComicType.values.byName(code.replaceAll('-', ''));
    } catch (_) {
      return ComicType.others;
    }
  }

  const ComicType(this.label, [this.flagCode]);

  final String label;
  final FlagsCode? flagCode;
  Flag? get flag => flagCode == null ? null : Flag.fromCode(flagCode!);
}

enum ComicStatus {
  ongoing(Icons.access_time, 'Ongoing'),
  completed(Icons.done_all, 'Completed'),
  cancelled(Icons.cancel, 'Cancelled'),
  hiatus(Icons.hourglass_empty_rounded, 'Hiatus');

  const ComicStatus(this.icon, this.label);

  final IconData icon;
  final String label;
}

class Comic {
  final String slug;
  final String hid;
  final String title;
  final List<String> aliases;
  final String? native;
  final String? cover;
  final ComicType type;
  final ComicStatus status;
  final int? year;
  final String? rating;
  final String? description;
  final List<String> genres;
  final List<String> artists;
  final List<String> authors;
  final List<Language> languages;
  final Chapter? firstChapter;

  Comic({
    required this.slug,
    required this.hid,
    required this.title,
    required this.aliases,
    required this.native,
    required this.cover,
    required this.type,
    required this.status,
    required this.year,
    required this.rating,
    required this.description,
    required this.genres,
    required this.artists,
    required this.authors,
    required this.languages,
    required this.firstChapter,
  });

  factory Comic.fromMap(Map<String, dynamic> map) {
    final comic = map['comic'];

    String? native;
    List<String> aliases = [];
    List<String> genres = [];

    for (var alias in comic['md_titles']) {
      if (alias['lang'] == comic['iso639_1']) {
        native = alias['title'];
      } else {
        aliases.add(alias['title']);
      }
    }

    return Comic(
      slug: comic['slug'],
      hid: comic['hid'],
      title: comic['title'],
      aliases: aliases,
      native: native,
      cover: comic['cover_url'],
      type: ComicType.fromCode(comic['country']),
      status: ComicStatus.values[comic['status'] - 1],
      year: comic['year'],
      rating: comic['bayesian_rating'],
      description: comic['parsed'],
      genres: genres,
      artists:
          (map['artists'] as List).map((e) => e['name'] as String).toList(),
      authors:
          (map['authors'] as List).map((e) => e['name'] as String).toList(),
      languages: (map['langList'] as List)
          .map((e) => Language.fromLangCode(e))
          .toList()
        ..insert(0, Language.all),
      firstChapter:
          map['firstChap'] == null ? null : Chapter.fromMap(map['firstChap']),
    );
  }

  @override
  String toString() {
    return 'Comic(slug: $slug, hid: $hid, title: $title, aliases: $aliases, native: $native, cover: $cover, type: $type, status: $status, year: $year, rating: $rating, description: $description, genres: $genres, artists: $artists, authors: $authors, languages: $languages, firstChapter: $firstChapter)';
  }
}
