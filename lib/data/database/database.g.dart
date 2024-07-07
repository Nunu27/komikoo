// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ComicsTable extends Comics
    with TableInfo<$ComicsTable, ComicCompactEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ComicsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
      'slug', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _coverMeta = const VerificationMeta('cover');
  @override
  late final GeneratedColumn<String> cover = GeneratedColumn<String>(
      'cover', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [slug, cover, title, isFavorite];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'comics';
  @override
  VerificationContext validateIntegrity(Insertable<ComicCompactEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('slug')) {
      context.handle(
          _slugMeta, slug.isAcceptableOrUnknown(data['slug']!, _slugMeta));
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('cover')) {
      context.handle(
          _coverMeta, cover.isAcceptableOrUnknown(data['cover']!, _coverMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {slug};
  @override
  ComicCompactEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ComicCompactEntity(
      slug: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slug'])!,
      cover: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cover']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
    );
  }

  @override
  $ComicsTable createAlias(String alias) {
    return $ComicsTable(attachedDatabase, alias);
  }
}

class ComicCompactEntity extends DataClass
    implements Insertable<ComicCompactEntity> {
  final String slug;
  final String? cover;
  final String title;
  final bool isFavorite;
  const ComicCompactEntity(
      {required this.slug,
      this.cover,
      required this.title,
      required this.isFavorite});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['slug'] = Variable<String>(slug);
    if (!nullToAbsent || cover != null) {
      map['cover'] = Variable<String>(cover);
    }
    map['title'] = Variable<String>(title);
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  ComicsCompanion toCompanion(bool nullToAbsent) {
    return ComicsCompanion(
      slug: Value(slug),
      cover:
          cover == null && nullToAbsent ? const Value.absent() : Value(cover),
      title: Value(title),
      isFavorite: Value(isFavorite),
    );
  }

  factory ComicCompactEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ComicCompactEntity(
      slug: serializer.fromJson<String>(json['slug']),
      cover: serializer.fromJson<String?>(json['cover']),
      title: serializer.fromJson<String>(json['title']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'slug': serializer.toJson<String>(slug),
      'cover': serializer.toJson<String?>(cover),
      'title': serializer.toJson<String>(title),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  ComicCompactEntity copyWith(
          {String? slug,
          Value<String?> cover = const Value.absent(),
          String? title,
          bool? isFavorite}) =>
      ComicCompactEntity(
        slug: slug ?? this.slug,
        cover: cover.present ? cover.value : this.cover,
        title: title ?? this.title,
        isFavorite: isFavorite ?? this.isFavorite,
      );
  @override
  String toString() {
    return (StringBuffer('ComicCompactEntity(')
          ..write('slug: $slug, ')
          ..write('cover: $cover, ')
          ..write('title: $title, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(slug, cover, title, isFavorite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ComicCompactEntity &&
          other.slug == this.slug &&
          other.cover == this.cover &&
          other.title == this.title &&
          other.isFavorite == this.isFavorite);
}

class ComicsCompanion extends UpdateCompanion<ComicCompactEntity> {
  final Value<String> slug;
  final Value<String?> cover;
  final Value<String> title;
  final Value<bool> isFavorite;
  final Value<int> rowid;
  const ComicsCompanion({
    this.slug = const Value.absent(),
    this.cover = const Value.absent(),
    this.title = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ComicsCompanion.insert({
    required String slug,
    this.cover = const Value.absent(),
    required String title,
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : slug = Value(slug),
        title = Value(title);
  static Insertable<ComicCompactEntity> custom({
    Expression<String>? slug,
    Expression<String>? cover,
    Expression<String>? title,
    Expression<bool>? isFavorite,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (slug != null) 'slug': slug,
      if (cover != null) 'cover': cover,
      if (title != null) 'title': title,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ComicsCompanion copyWith(
      {Value<String>? slug,
      Value<String?>? cover,
      Value<String>? title,
      Value<bool>? isFavorite,
      Value<int>? rowid}) {
    return ComicsCompanion(
      slug: slug ?? this.slug,
      cover: cover ?? this.cover,
      title: title ?? this.title,
      isFavorite: isFavorite ?? this.isFavorite,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (cover.present) {
      map['cover'] = Variable<String>(cover.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ComicsCompanion(')
          ..write('slug: $slug, ')
          ..write('cover: $cover, ')
          ..write('title: $title, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReadingProgressesTable extends ReadingProgresses
    with TableInfo<$ReadingProgressesTable, ReadingProgressEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingProgressesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _hidMeta = const VerificationMeta('hid');
  @override
  late final GeneratedColumn<String> hid = GeneratedColumn<String>(
      'hid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _comicSlugMeta =
      const VerificationMeta('comicSlug');
  @override
  late final GeneratedColumn<String> comicSlug = GeneratedColumn<String>(
      'comic_slug', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES comics (slug) ON UPDATE CASCADE ON DELETE CASCADE'));
  static const VerificationMeta _progressMeta =
      const VerificationMeta('progress');
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
      'progress', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [hid, title, comicSlug, progress, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_progresses';
  @override
  VerificationContext validateIntegrity(
      Insertable<ReadingProgressEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('hid')) {
      context.handle(
          _hidMeta, hid.isAcceptableOrUnknown(data['hid']!, _hidMeta));
    } else if (isInserting) {
      context.missing(_hidMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('comic_slug')) {
      context.handle(_comicSlugMeta,
          comicSlug.isAcceptableOrUnknown(data['comic_slug']!, _comicSlugMeta));
    } else if (isInserting) {
      context.missing(_comicSlugMeta);
    }
    if (data.containsKey('progress')) {
      context.handle(_progressMeta,
          progress.isAcceptableOrUnknown(data['progress']!, _progressMeta));
    } else if (isInserting) {
      context.missing(_progressMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {hid};
  @override
  ReadingProgressEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingProgressEntity(
      hid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hid'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      comicSlug: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comic_slug'])!,
      progress: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}progress'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $ReadingProgressesTable createAlias(String alias) {
    return $ReadingProgressesTable(attachedDatabase, alias);
  }
}

class ReadingProgressEntity extends DataClass
    implements Insertable<ReadingProgressEntity> {
  final String hid;
  final String title;
  final String comicSlug;
  final double progress;
  final DateTime date;
  const ReadingProgressEntity(
      {required this.hid,
      required this.title,
      required this.comicSlug,
      required this.progress,
      required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['hid'] = Variable<String>(hid);
    map['title'] = Variable<String>(title);
    map['comic_slug'] = Variable<String>(comicSlug);
    map['progress'] = Variable<double>(progress);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  ReadingProgressesCompanion toCompanion(bool nullToAbsent) {
    return ReadingProgressesCompanion(
      hid: Value(hid),
      title: Value(title),
      comicSlug: Value(comicSlug),
      progress: Value(progress),
      date: Value(date),
    );
  }

  factory ReadingProgressEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingProgressEntity(
      hid: serializer.fromJson<String>(json['hid']),
      title: serializer.fromJson<String>(json['title']),
      comicSlug: serializer.fromJson<String>(json['comicSlug']),
      progress: serializer.fromJson<double>(json['progress']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'hid': serializer.toJson<String>(hid),
      'title': serializer.toJson<String>(title),
      'comicSlug': serializer.toJson<String>(comicSlug),
      'progress': serializer.toJson<double>(progress),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  ReadingProgressEntity copyWith(
          {String? hid,
          String? title,
          String? comicSlug,
          double? progress,
          DateTime? date}) =>
      ReadingProgressEntity(
        hid: hid ?? this.hid,
        title: title ?? this.title,
        comicSlug: comicSlug ?? this.comicSlug,
        progress: progress ?? this.progress,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('ReadingProgressEntity(')
          ..write('hid: $hid, ')
          ..write('title: $title, ')
          ..write('comicSlug: $comicSlug, ')
          ..write('progress: $progress, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(hid, title, comicSlug, progress, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingProgressEntity &&
          other.hid == this.hid &&
          other.title == this.title &&
          other.comicSlug == this.comicSlug &&
          other.progress == this.progress &&
          other.date == this.date);
}

class ReadingProgressesCompanion
    extends UpdateCompanion<ReadingProgressEntity> {
  final Value<String> hid;
  final Value<String> title;
  final Value<String> comicSlug;
  final Value<double> progress;
  final Value<DateTime> date;
  final Value<int> rowid;
  const ReadingProgressesCompanion({
    this.hid = const Value.absent(),
    this.title = const Value.absent(),
    this.comicSlug = const Value.absent(),
    this.progress = const Value.absent(),
    this.date = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReadingProgressesCompanion.insert({
    required String hid,
    required String title,
    required String comicSlug,
    required double progress,
    required DateTime date,
    this.rowid = const Value.absent(),
  })  : hid = Value(hid),
        title = Value(title),
        comicSlug = Value(comicSlug),
        progress = Value(progress),
        date = Value(date);
  static Insertable<ReadingProgressEntity> custom({
    Expression<String>? hid,
    Expression<String>? title,
    Expression<String>? comicSlug,
    Expression<double>? progress,
    Expression<DateTime>? date,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (hid != null) 'hid': hid,
      if (title != null) 'title': title,
      if (comicSlug != null) 'comic_slug': comicSlug,
      if (progress != null) 'progress': progress,
      if (date != null) 'date': date,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReadingProgressesCompanion copyWith(
      {Value<String>? hid,
      Value<String>? title,
      Value<String>? comicSlug,
      Value<double>? progress,
      Value<DateTime>? date,
      Value<int>? rowid}) {
    return ReadingProgressesCompanion(
      hid: hid ?? this.hid,
      title: title ?? this.title,
      comicSlug: comicSlug ?? this.comicSlug,
      progress: progress ?? this.progress,
      date: date ?? this.date,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (hid.present) {
      map['hid'] = Variable<String>(hid.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (comicSlug.present) {
      map['comic_slug'] = Variable<String>(comicSlug.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingProgressesCompanion(')
          ..write('hid: $hid, ')
          ..write('title: $title, ')
          ..write('comicSlug: $comicSlug, ')
          ..write('progress: $progress, ')
          ..write('date: $date, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $ComicsTable comics = $ComicsTable(this);
  late final $ReadingProgressesTable readingProgresses =
      $ReadingProgressesTable(this);
  late final Index comicFavorites = Index('comic_favorites',
      'CREATE INDEX comic_favorites ON comics (is_favorite)');
  late final Index comicProgresses = Index('comic_progresses',
      'CREATE INDEX comic_progresses ON reading_progresses (comic_slug, progress)');
  late final FavoriteDao favoriteDao = FavoriteDao(this as Database);
  late final HistoryDao historyDao = HistoryDao(this as Database);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [comics, readingProgresses, comicFavorites, comicProgresses];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('comics',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('reading_progresses', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('comics',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('reading_progresses', kind: UpdateKind.update),
            ],
          ),
        ],
      );
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$databaseHash() => r'e4fbcd79c505e8d87cac73397a38be8a6f405b5f';

/// See also [database].
@ProviderFor(database)
final databaseProvider = AutoDisposeProvider<Database>.internal(
  database,
  name: r'databaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$databaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DatabaseRef = AutoDisposeProviderRef<Database>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
