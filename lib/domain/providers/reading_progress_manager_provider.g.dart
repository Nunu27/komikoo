// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_progress_manager_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$readingProgressManagerHash() =>
    r'0260dc71e874bd0968c62b30f4a920ab5b201414';

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

abstract class _$ReadingProgressManager
    extends BuildlessAutoDisposeNotifier<double> {
  late final String comicSlug;

  double build(
    String comicSlug,
  );
}

/// See also [ReadingProgressManager].
@ProviderFor(ReadingProgressManager)
const readingProgressManagerProvider = ReadingProgressManagerFamily();

/// See also [ReadingProgressManager].
class ReadingProgressManagerFamily extends Family<double> {
  /// See also [ReadingProgressManager].
  const ReadingProgressManagerFamily();

  /// See also [ReadingProgressManager].
  ReadingProgressManagerProvider call(
    String comicSlug,
  ) {
    return ReadingProgressManagerProvider(
      comicSlug,
    );
  }

  @override
  ReadingProgressManagerProvider getProviderOverride(
    covariant ReadingProgressManagerProvider provider,
  ) {
    return call(
      provider.comicSlug,
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
  String? get name => r'readingProgressManagerProvider';
}

/// See also [ReadingProgressManager].
class ReadingProgressManagerProvider
    extends AutoDisposeNotifierProviderImpl<ReadingProgressManager, double> {
  /// See also [ReadingProgressManager].
  ReadingProgressManagerProvider(
    String comicSlug,
  ) : this._internal(
          () => ReadingProgressManager()..comicSlug = comicSlug,
          from: readingProgressManagerProvider,
          name: r'readingProgressManagerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$readingProgressManagerHash,
          dependencies: ReadingProgressManagerFamily._dependencies,
          allTransitiveDependencies:
              ReadingProgressManagerFamily._allTransitiveDependencies,
          comicSlug: comicSlug,
        );

  ReadingProgressManagerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.comicSlug,
  }) : super.internal();

  final String comicSlug;

  @override
  double runNotifierBuild(
    covariant ReadingProgressManager notifier,
  ) {
    return notifier.build(
      comicSlug,
    );
  }

  @override
  Override overrideWith(ReadingProgressManager Function() create) {
    return ProviderOverride(
      origin: this,
      override: ReadingProgressManagerProvider._internal(
        () => create()..comicSlug = comicSlug,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        comicSlug: comicSlug,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ReadingProgressManager, double>
      createElement() {
    return _ReadingProgressManagerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReadingProgressManagerProvider &&
        other.comicSlug == comicSlug;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, comicSlug.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ReadingProgressManagerRef on AutoDisposeNotifierProviderRef<double> {
  /// The parameter `comicSlug` of this provider.
  String get comicSlug;
}

class _ReadingProgressManagerProviderElement
    extends AutoDisposeNotifierProviderElement<ReadingProgressManager, double>
    with ReadingProgressManagerRef {
  _ReadingProgressManagerProviderElement(super.provider);

  @override
  String get comicSlug => (origin as ReadingProgressManagerProvider).comicSlug;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
