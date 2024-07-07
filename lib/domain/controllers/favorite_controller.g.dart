// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoriteControllerHash() =>
    r'b5a2200cfb12f095a99a84a422e3887679b19881';

/// See also [favoriteController].
@ProviderFor(favoriteController)
final favoriteControllerProvider =
    AutoDisposeProvider<FavoriteController>.internal(
  favoriteController,
  name: r'favoriteControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FavoriteControllerRef = AutoDisposeProviderRef<FavoriteController>;
String _$favoritesComicHash() => r'8a8dc2f344a1501e5fadf2e558bb9741730ff3b0';

/// See also [favoritesComic].
@ProviderFor(favoritesComic)
final favoritesComicProvider =
    AutoDisposeStreamProvider<List<ComicCompact>>.internal(
  favoritesComic,
  name: r'favoritesComicProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoritesComicHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FavoritesComicRef = AutoDisposeStreamProviderRef<List<ComicCompact>>;
String _$isFavoriteHash() => r'6638b961289633593c0235f75a3d4bfeb4e206b4';

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

/// See also [isFavorite].
@ProviderFor(isFavorite)
const isFavoriteProvider = IsFavoriteFamily();

/// See also [isFavorite].
class IsFavoriteFamily extends Family<AsyncValue<bool>> {
  /// See also [isFavorite].
  const IsFavoriteFamily();

  /// See also [isFavorite].
  IsFavoriteProvider call(
    String slug,
  ) {
    return IsFavoriteProvider(
      slug,
    );
  }

  @override
  IsFavoriteProvider getProviderOverride(
    covariant IsFavoriteProvider provider,
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
  String? get name => r'isFavoriteProvider';
}

/// See also [isFavorite].
class IsFavoriteProvider extends AutoDisposeStreamProvider<bool> {
  /// See also [isFavorite].
  IsFavoriteProvider(
    String slug,
  ) : this._internal(
          (ref) => isFavorite(
            ref as IsFavoriteRef,
            slug,
          ),
          from: isFavoriteProvider,
          name: r'isFavoriteProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isFavoriteHash,
          dependencies: IsFavoriteFamily._dependencies,
          allTransitiveDependencies:
              IsFavoriteFamily._allTransitiveDependencies,
          slug: slug,
        );

  IsFavoriteProvider._internal(
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
    Stream<bool> Function(IsFavoriteRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsFavoriteProvider._internal(
        (ref) => create(ref as IsFavoriteRef),
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
  AutoDisposeStreamProviderElement<bool> createElement() {
    return _IsFavoriteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsFavoriteProvider && other.slug == slug;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, slug.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IsFavoriteRef on AutoDisposeStreamProviderRef<bool> {
  /// The parameter `slug` of this provider.
  String get slug;
}

class _IsFavoriteProviderElement extends AutoDisposeStreamProviderElement<bool>
    with IsFavoriteRef {
  _IsFavoriteProviderElement(super.provider);

  @override
  String get slug => (origin as IsFavoriteProvider).slug;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
