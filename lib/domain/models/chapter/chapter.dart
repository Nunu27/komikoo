import 'package:flag/flag.dart';

enum Language {
  all('All language'),
  en('English', countryCode: 'gb'),
  ptbr('português do Brasil', countryCode: 'pt', langCode: 'pt-br'),
  ru('русский язык'),
  fr('français, langue française'),
  es419('español latinoamericano', countryCode: 'mx', langCode: 'es-419'),
  pl('polski'),
  tr('Türkçe'),
  id('Bahasa Indonesia'),
  it('Italiano'),
  es('español, castellano'),
  vi('Tiếng Việt', countryCode: 'vn'),
  zhhk('(Hong Kong) 繁體中文', countryCode: 'cn', langCode: 'zh-hk'),
  ar('العربية', countryCode: 'sa'),
  hu('Magyar'),
  uk('українська', countryCode: 'ua'),
  de('Deutsch'),
  zh('中文 (Zhōngwén), 汉语, 漢語', countryCode: 'cn'),
  ko('한국어 (韓國語), 조선말 (朝鮮語)', countryCode: 'kr'),
  th('ไทย'),
  ca('Català'),
  bg('български език'),
  fa('فارسی', countryCode: 'ir'),
  ro('română'),
  cs('česky, čeština', countryCode: 'cz'),
  mn('монгол'),
  pt('Português'),
  he('עברית', countryCode: 'il'),
  hi('हिन्दी, हिंदी', countryCode: 'in'),
  tl('Wikang Tagalog', countryCode: 'ph'),
  ms('bahasa Melayu', countryCode: 'my'),
  kk('Қазақ тілі', countryCode: 'kz'),
  my('ဗမာစာ', countryCode: 'mm'),
  ja('日本語', countryCode: 'jp'),
  nl('Nederlands, Vlaams', countryCode: 'np'),
  sr('српски језик', countryCode: 'rs'),
  el('Ελληνικά', countryCode: 'gr'),
  fi('suomi, suomen kieli'),
  lt('lietuvių kalba'),
  sv('svenska', countryCode: 'se'),
  bn('বাংলা', countryCode: 'bd'),
  ta('தமிழ்', countryCode: 'in'),
  ne('नेपाली'),
  la('latine, lingua latina'),
  hr('hrvatski'),
  no('Norsk'),
  ka('ქართული'),
  sq('Shqip'),
  te('తెలుగు'),
  az('azərbaycan dili'),
  et('eesti, eesti keel'),
  sk('slovenčina'),
  da('dansk', countryCode: 'dk'),
  sl('slovenščina');

  static Language fromLangCode(String code) {
    return Language.values.byName(code.replaceAll('-', ''));
  }

  const Language(this.label, {this.countryCode, String? langCode})
      : _langCode = langCode;

  final String label;
  final String? countryCode;
  final String? _langCode;
  String? get langCode => this == Language.all ? null : _langCode ?? name;
  Flag? get flag => this == Language.all
      ? null
      : Flag.fromString(
          countryCode ?? name,
          height: 24,
          width: 24,
        );
}

class Chapter {
  final int index;
  final String hid;
  final String? chap;
  final String? vol;
  final String? title;
  final Language lang;
  final List<String> groups;
  final DateTime? date;

  Chapter({
    required this.index,
    required this.hid,
    required this.chap,
    required this.vol,
    required this.title,
    required this.lang,
    required this.groups,
    required this.date,
  });

  String getSimpleTitle() {
    if (chap != null) {
      return 'Chapter $chap';
    } else if (vol != null) {
      return 'Volume $vol';
    } else if (title != null) {
      return title!;
    } else {
      return 'Oneshot';
    }
  }

  String getTitle() {
    List<String> info = [];

    if (vol != null) {
      info.add('Vol. $vol');
    }
    if (chap != null) {
      info.add('Ch. $chap');
    }

    final String text = info.join(' ');
    info.clear();

    if (text.isNotEmpty) {
      info.add(text);
    }
    if (title != null) {
      info.add(title!);
    }

    return info.isEmpty ? 'Oneshot' : info.join(': ');
  }

  factory Chapter.fromMap(Map<String, dynamic> map, {int index = 0}) {
    final title = map['title'] as String?;

    return Chapter(
      index: index,
      hid: map['hid'] as String,
      chap: map['chap'] != null ? map['chap'] as String : null,
      vol: (map['vol'] != null ? map['vol'] as String : null),
      title: (title?.isEmpty ?? true) ? null : title,
      lang: Language.fromLangCode(map['lang']),
      groups: List<String>.from((['groups'] as List).map((e) => e as String)),
      date:
          map['updated_at'] == null ? null : DateTime.parse(map['updated_at']),
    );
  }

  @override
  String toString() {
    return 'Chapter(index: $index, hid: $hid, chap: $chap, vol: $vol, title: $title, lang: $lang, groups: $groups, date: $date)';
  }

  @override
  bool operator ==(covariant Chapter other) {
    if (identical(this, other)) return true;

    return other.hid == hid;
  }

  @override
  int get hashCode {
    return hid.hashCode;
  }
}
