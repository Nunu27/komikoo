// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$historyControllerHash() => r'81a2c8aa34a96629b24b3819a9c8076c4ff2540e';

/// See also [historyController].
@ProviderFor(historyController)
final historyControllerProvider =
    AutoDisposeProvider<HistoryController>.internal(
  historyController,
  name: r'historyControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$historyControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HistoryControllerRef = AutoDisposeProviderRef<HistoryController>;
String _$historyListHash() => r'5c05567cd3c6850d31b8960d7807e7b12657a65f';

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

/// See also [historyList].
@ProviderFor(historyList)
const historyListProvider = HistoryListFamily();

/// See also [historyList].
class HistoryListFamily extends Family<AsyncValue<List<ComicWithProgress>>> {
  /// See also [historyList].
  const HistoryListFamily();

  /// See also [historyList].
  HistoryListProvider call({
    int? limit,
    bool? completed,
  }) {
    return HistoryListProvider(
      limit: limit,
      completed: completed,
    );
  }

  @override
  HistoryListProvider getProviderOverride(
    covariant HistoryListProvider provider,
  ) {
    return call(
      limit: provider.limit,
      completed: provider.completed,
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
  String? get name => r'historyListProvider';
}

/// See also [historyList].
class HistoryListProvider
    extends AutoDisposeStreamProvider<List<ComicWithProgress>> {
  /// See also [historyList].
  HistoryListProvider({
    int? limit,
    bool? completed,
  }) : this._internal(
          (ref) => historyList(
            ref as HistoryListRef,
            limit: limit,
            completed: completed,
          ),
          from: historyListProvider,
          name: r'historyListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$historyListHash,
          dependencies: HistoryListFamily._dependencies,
          allTransitiveDependencies:
              HistoryListFamily._allTransitiveDependencies,
          limit: limit,
          completed: completed,
        );

  HistoryListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.limit,
    required this.completed,
  }) : super.internal();

  final int? limit;
  final bool? completed;

  @override
  Override overrideWith(
    Stream<List<ComicWithProgress>> Function(HistoryListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HistoryListProvider._internal(
        (ref) => create(ref as HistoryListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        limit: limit,
        completed: completed,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<ComicWithProgress>> createElement() {
    return _HistoryListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HistoryListProvider &&
        other.limit == limit &&
        other.completed == completed;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);
    hash = _SystemHash.combine(hash, completed.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin HistoryListRef on AutoDisposeStreamProviderRef<List<ComicWithProgress>> {
  /// The parameter `limit` of this provider.
  int? get limit;

  /// The parameter `completed` of this provider.
  bool? get completed;
}

class _HistoryListProviderElement
    extends AutoDisposeStreamProviderElement<List<ComicWithProgress>>
    with HistoryListRef {
  _HistoryListProviderElement(super.provider);

  @override
  int? get limit => (origin as HistoryListProvider).limit;
  @override
  bool? get completed => (origin as HistoryListProvider).completed;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
