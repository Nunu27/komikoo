// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comic_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$comicControllerHash() => r'675664376b8cdb7874c277cb8823c2937b0d5b79';

/// See also [comicController].
@ProviderFor(comicController)
final comicControllerProvider = AutoDisposeProvider<ComicController>.internal(
  comicController,
  name: r'comicControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$comicControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ComicControllerRef = AutoDisposeProviderRef<ComicController>;
String _$getFeedHash() => r'499ecbb636384d02e9f5c1c855293f6c8af757b8';

/// See also [getFeed].
@ProviderFor(getFeed)
final getFeedProvider = AutoDisposeFutureProvider<List<Feed>>.internal(
  getFeed,
  name: r'getFeedProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getFeedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetFeedRef = AutoDisposeFutureProviderRef<List<Feed>>;
String _$getDetailsHash() => r'bdd5c35377083d7d4cee1a15dcf5eb7b3ee66392';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getDetails].
@ProviderFor(getDetails)
const getDetailsProvider = GetDetailsFamily();

/// See also [getDetails].
class GetDetailsFamily extends Family<AsyncValue<Comic>> {
  /// See also [getDetails].
  const GetDetailsFamily();

  /// See also [getDetails].
  GetDetailsProvider call(
    String slug,
  ) {
    return GetDetailsProvider(
      slug,
    );
  }

  @override
  GetDetailsProvider getProviderOverride(
    covariant GetDetailsProvider provider,
  ) {
    return call(
      provider.slug,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getDetailsProvider';
}

/// See also [getDetails].
class GetDetailsProvider extends AutoDisposeFutureProvider<Comic> {
  /// See also [getDetails].
  GetDetailsProvider(
    String slug,
  ) : this._internal(
          (ref) => getDetails(
            ref as GetDetailsRef,
            slug,
          ),
          from: getDetailsProvider,
          name: r'getDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDetailsHash,
          dependencies: GetDetailsFamily._dependencies,
          allTransitiveDependencies:
              GetDetailsFamily._allTransitiveDependencies,
          slug: slug,
        );

  GetDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.slug,
  }) : super.internal();

  final String slug;

  @override
  Override overrideWith(
    FutureOr<Comic> Function(GetDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetDetailsProvider._internal(
        (ref) => create(ref as GetDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        slug: slug,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Comic> createElement() {
    return _GetDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetDetailsProvider && other.slug == slug;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, slug.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetDetailsRef on AutoDisposeFutureProviderRef<Comic> {
  /// The parameter `slug` of this provider.
  String get slug;
}

class _GetDetailsProviderElement extends AutoDisposeFutureProviderElement<Comic>
    with GetDetailsRef {
  _GetDetailsProviderElement(super.provider);

  @override
  String get slug => (origin as GetDetailsProvider).slug;
}

String _$getChapterHash() => r'404d1ab73317f1c01d27ddafb19df7cfa4ffad12';

/// See also [getChapter].
@ProviderFor(getChapter)
const getChapterProvider = GetChapterFamily();

/// See also [getChapter].
class GetChapterFamily extends Family<AsyncValue<ChapterData>> {
  /// See also [getChapter].
  const GetChapterFamily();

  /// See also [getChapter].
  GetChapterProvider call(
    String hid,
  ) {
    return GetChapterProvider(
      hid,
    );
  }

  @override
  GetChapterProvider getProviderOverride(
    covariant GetChapterProvider provider,
  ) {
    return call(
      provider.hid,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getChapterProvider';
}

/// See also [getChapter].
class GetChapterProvider extends AutoDisposeFutureProvider<ChapterData> {
  /// See also [getChapter].
  GetChapterProvider(
    String hid,
  ) : this._internal(
          (ref) => getChapter(
            ref as GetChapterRef,
            hid,
          ),
          from: getChapterProvider,
          name: r'getChapterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getChapterHash,
          dependencies: GetChapterFamily._dependencies,
          allTransitiveDependencies:
              GetChapterFamily._allTransitiveDependencies,
          hid: hid,
        );

  GetChapterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.hid,
  }) : super.internal();

  final String hid;

  @override
  Override overrideWith(
    FutureOr<ChapterData> Function(GetChapterRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetChapterProvider._internal(
        (ref) => create(ref as GetChapterRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        hid: hid,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ChapterData> createElement() {
    return _GetChapterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetChapterProvider && other.hid == hid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, hid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetChapterRef on AutoDisposeFutureProviderRef<ChapterData> {
  /// The parameter `hid` of this provider.
  String get hid;
}

class _GetChapterProviderElement
    extends AutoDisposeFutureProviderElement<ChapterData> with GetChapterRef {
  _GetChapterProviderElement(super.provider);

  @override
  String get hid => (origin as GetChapterProvider).hid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
