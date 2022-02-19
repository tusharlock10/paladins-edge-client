// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'loadout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CreateLoadoutScreenArgumentsTearOff {
  const _$CreateLoadoutScreenArgumentsTearOff();

  _CreateLoadoutScreenArguments call(
      {required Champion champion, Loadout? loadout}) {
    return _CreateLoadoutScreenArguments(
      champion: champion,
      loadout: loadout,
    );
  }
}

/// @nodoc
const $CreateLoadoutScreenArguments = _$CreateLoadoutScreenArgumentsTearOff();

/// @nodoc
mixin _$CreateLoadoutScreenArguments {
  Champion get champion => throw _privateConstructorUsedError;
  Loadout? get loadout => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateLoadoutScreenArgumentsCopyWith<CreateLoadoutScreenArguments>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateLoadoutScreenArgumentsCopyWith<$Res> {
  factory $CreateLoadoutScreenArgumentsCopyWith(
          CreateLoadoutScreenArguments value,
          $Res Function(CreateLoadoutScreenArguments) then) =
      _$CreateLoadoutScreenArgumentsCopyWithImpl<$Res>;
  $Res call({Champion champion, Loadout? loadout});
}

/// @nodoc
class _$CreateLoadoutScreenArgumentsCopyWithImpl<$Res>
    implements $CreateLoadoutScreenArgumentsCopyWith<$Res> {
  _$CreateLoadoutScreenArgumentsCopyWithImpl(this._value, this._then);

  final CreateLoadoutScreenArguments _value;
  // ignore: unused_field
  final $Res Function(CreateLoadoutScreenArguments) _then;

  @override
  $Res call({
    Object? champion = freezed,
    Object? loadout = freezed,
  }) {
    return _then(_value.copyWith(
      champion: champion == freezed
          ? _value.champion
          : champion // ignore: cast_nullable_to_non_nullable
              as Champion,
      loadout: loadout == freezed
          ? _value.loadout
          : loadout // ignore: cast_nullable_to_non_nullable
              as Loadout?,
    ));
  }
}

/// @nodoc
abstract class _$CreateLoadoutScreenArgumentsCopyWith<$Res>
    implements $CreateLoadoutScreenArgumentsCopyWith<$Res> {
  factory _$CreateLoadoutScreenArgumentsCopyWith(
          _CreateLoadoutScreenArguments value,
          $Res Function(_CreateLoadoutScreenArguments) then) =
      __$CreateLoadoutScreenArgumentsCopyWithImpl<$Res>;
  @override
  $Res call({Champion champion, Loadout? loadout});
}

/// @nodoc
class __$CreateLoadoutScreenArgumentsCopyWithImpl<$Res>
    extends _$CreateLoadoutScreenArgumentsCopyWithImpl<$Res>
    implements _$CreateLoadoutScreenArgumentsCopyWith<$Res> {
  __$CreateLoadoutScreenArgumentsCopyWithImpl(
      _CreateLoadoutScreenArguments _value,
      $Res Function(_CreateLoadoutScreenArguments) _then)
      : super(_value, (v) => _then(v as _CreateLoadoutScreenArguments));

  @override
  _CreateLoadoutScreenArguments get _value =>
      super._value as _CreateLoadoutScreenArguments;

  @override
  $Res call({
    Object? champion = freezed,
    Object? loadout = freezed,
  }) {
    return _then(_CreateLoadoutScreenArguments(
      champion: champion == freezed
          ? _value.champion
          : champion // ignore: cast_nullable_to_non_nullable
              as Champion,
      loadout: loadout == freezed
          ? _value.loadout
          : loadout // ignore: cast_nullable_to_non_nullable
              as Loadout?,
    ));
  }
}

/// @nodoc

class _$_CreateLoadoutScreenArguments implements _CreateLoadoutScreenArguments {
  _$_CreateLoadoutScreenArguments({required this.champion, this.loadout});

  @override
  final Champion champion;
  @override
  final Loadout? loadout;

  @override
  String toString() {
    return 'CreateLoadoutScreenArguments(champion: $champion, loadout: $loadout)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreateLoadoutScreenArguments &&
            const DeepCollectionEquality().equals(other.champion, champion) &&
            const DeepCollectionEquality().equals(other.loadout, loadout));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(champion),
      const DeepCollectionEquality().hash(loadout));

  @JsonKey(ignore: true)
  @override
  _$CreateLoadoutScreenArgumentsCopyWith<_CreateLoadoutScreenArguments>
      get copyWith => __$CreateLoadoutScreenArgumentsCopyWithImpl<
          _CreateLoadoutScreenArguments>(this, _$identity);
}

abstract class _CreateLoadoutScreenArguments
    implements CreateLoadoutScreenArguments {
  factory _CreateLoadoutScreenArguments(
      {required Champion champion,
      Loadout? loadout}) = _$_CreateLoadoutScreenArguments;

  @override
  Champion get champion;
  @override
  Loadout? get loadout;
  @override
  @JsonKey(ignore: true)
  _$CreateLoadoutScreenArgumentsCopyWith<_CreateLoadoutScreenArguments>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
class _$LoadoutValidationResultTearOff {
  const _$LoadoutValidationResultTearOff();

  _LoadoutValidationResult call({required bool result, required String error}) {
    return _LoadoutValidationResult(
      result: result,
      error: error,
    );
  }
}

/// @nodoc
const $LoadoutValidationResult = _$LoadoutValidationResultTearOff();

/// @nodoc
mixin _$LoadoutValidationResult {
  bool get result => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoadoutValidationResultCopyWith<LoadoutValidationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoadoutValidationResultCopyWith<$Res> {
  factory $LoadoutValidationResultCopyWith(LoadoutValidationResult value,
          $Res Function(LoadoutValidationResult) then) =
      _$LoadoutValidationResultCopyWithImpl<$Res>;
  $Res call({bool result, String error});
}

/// @nodoc
class _$LoadoutValidationResultCopyWithImpl<$Res>
    implements $LoadoutValidationResultCopyWith<$Res> {
  _$LoadoutValidationResultCopyWithImpl(this._value, this._then);

  final LoadoutValidationResult _value;
  // ignore: unused_field
  final $Res Function(LoadoutValidationResult) _then;

  @override
  $Res call({
    Object? result = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as bool,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$LoadoutValidationResultCopyWith<$Res>
    implements $LoadoutValidationResultCopyWith<$Res> {
  factory _$LoadoutValidationResultCopyWith(_LoadoutValidationResult value,
          $Res Function(_LoadoutValidationResult) then) =
      __$LoadoutValidationResultCopyWithImpl<$Res>;
  @override
  $Res call({bool result, String error});
}

/// @nodoc
class __$LoadoutValidationResultCopyWithImpl<$Res>
    extends _$LoadoutValidationResultCopyWithImpl<$Res>
    implements _$LoadoutValidationResultCopyWith<$Res> {
  __$LoadoutValidationResultCopyWithImpl(_LoadoutValidationResult _value,
      $Res Function(_LoadoutValidationResult) _then)
      : super(_value, (v) => _then(v as _LoadoutValidationResult));

  @override
  _LoadoutValidationResult get _value =>
      super._value as _LoadoutValidationResult;

  @override
  $Res call({
    Object? result = freezed,
    Object? error = freezed,
  }) {
    return _then(_LoadoutValidationResult(
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as bool,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LoadoutValidationResult implements _LoadoutValidationResult {
  _$_LoadoutValidationResult({required this.result, required this.error});

  @override
  final bool result;
  @override
  final String error;

  @override
  String toString() {
    return 'LoadoutValidationResult(result: $result, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoadoutValidationResult &&
            const DeepCollectionEquality().equals(other.result, result) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(result),
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$LoadoutValidationResultCopyWith<_LoadoutValidationResult> get copyWith =>
      __$LoadoutValidationResultCopyWithImpl<_LoadoutValidationResult>(
          this, _$identity);
}

abstract class _LoadoutValidationResult implements LoadoutValidationResult {
  factory _LoadoutValidationResult(
      {required bool result,
      required String error}) = _$_LoadoutValidationResult;

  @override
  bool get result;
  @override
  String get error;
  @override
  @JsonKey(ignore: true)
  _$LoadoutValidationResultCopyWith<_LoadoutValidationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$DraftLoadoutTearOff {
  const _$DraftLoadoutTearOff();

  _DraftLoadout call(
      {required int championId,
      required String playerId,
      required String name,
      required List<LoadoutCard?> loadoutCards,
      required bool isImported,
      String? loadoutHash}) {
    return _DraftLoadout(
      championId: championId,
      playerId: playerId,
      name: name,
      loadoutCards: loadoutCards,
      isImported: isImported,
      loadoutHash: loadoutHash,
    );
  }
}

/// @nodoc
const $DraftLoadout = _$DraftLoadoutTearOff();

/// @nodoc
mixin _$DraftLoadout {
  int get championId => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<LoadoutCard?> get loadoutCards => throw _privateConstructorUsedError;
  bool get isImported => throw _privateConstructorUsedError;
  String? get loadoutHash => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DraftLoadoutCopyWith<DraftLoadout> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DraftLoadoutCopyWith<$Res> {
  factory $DraftLoadoutCopyWith(
          DraftLoadout value, $Res Function(DraftLoadout) then) =
      _$DraftLoadoutCopyWithImpl<$Res>;
  $Res call(
      {int championId,
      String playerId,
      String name,
      List<LoadoutCard?> loadoutCards,
      bool isImported,
      String? loadoutHash});
}

/// @nodoc
class _$DraftLoadoutCopyWithImpl<$Res> implements $DraftLoadoutCopyWith<$Res> {
  _$DraftLoadoutCopyWithImpl(this._value, this._then);

  final DraftLoadout _value;
  // ignore: unused_field
  final $Res Function(DraftLoadout) _then;

  @override
  $Res call({
    Object? championId = freezed,
    Object? playerId = freezed,
    Object? name = freezed,
    Object? loadoutCards = freezed,
    Object? isImported = freezed,
    Object? loadoutHash = freezed,
  }) {
    return _then(_value.copyWith(
      championId: championId == freezed
          ? _value.championId
          : championId // ignore: cast_nullable_to_non_nullable
              as int,
      playerId: playerId == freezed
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      loadoutCards: loadoutCards == freezed
          ? _value.loadoutCards
          : loadoutCards // ignore: cast_nullable_to_non_nullable
              as List<LoadoutCard?>,
      isImported: isImported == freezed
          ? _value.isImported
          : isImported // ignore: cast_nullable_to_non_nullable
              as bool,
      loadoutHash: loadoutHash == freezed
          ? _value.loadoutHash
          : loadoutHash // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$DraftLoadoutCopyWith<$Res>
    implements $DraftLoadoutCopyWith<$Res> {
  factory _$DraftLoadoutCopyWith(
          _DraftLoadout value, $Res Function(_DraftLoadout) then) =
      __$DraftLoadoutCopyWithImpl<$Res>;
  @override
  $Res call(
      {int championId,
      String playerId,
      String name,
      List<LoadoutCard?> loadoutCards,
      bool isImported,
      String? loadoutHash});
}

/// @nodoc
class __$DraftLoadoutCopyWithImpl<$Res> extends _$DraftLoadoutCopyWithImpl<$Res>
    implements _$DraftLoadoutCopyWith<$Res> {
  __$DraftLoadoutCopyWithImpl(
      _DraftLoadout _value, $Res Function(_DraftLoadout) _then)
      : super(_value, (v) => _then(v as _DraftLoadout));

  @override
  _DraftLoadout get _value => super._value as _DraftLoadout;

  @override
  $Res call({
    Object? championId = freezed,
    Object? playerId = freezed,
    Object? name = freezed,
    Object? loadoutCards = freezed,
    Object? isImported = freezed,
    Object? loadoutHash = freezed,
  }) {
    return _then(_DraftLoadout(
      championId: championId == freezed
          ? _value.championId
          : championId // ignore: cast_nullable_to_non_nullable
              as int,
      playerId: playerId == freezed
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      loadoutCards: loadoutCards == freezed
          ? _value.loadoutCards
          : loadoutCards // ignore: cast_nullable_to_non_nullable
              as List<LoadoutCard?>,
      isImported: isImported == freezed
          ? _value.isImported
          : isImported // ignore: cast_nullable_to_non_nullable
              as bool,
      loadoutHash: loadoutHash == freezed
          ? _value.loadoutHash
          : loadoutHash // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_DraftLoadout implements _DraftLoadout {
  _$_DraftLoadout(
      {required this.championId,
      required this.playerId,
      required this.name,
      required this.loadoutCards,
      required this.isImported,
      this.loadoutHash});

  @override
  final int championId;
  @override
  final String playerId;
  @override
  final String name;
  @override
  final List<LoadoutCard?> loadoutCards;
  @override
  final bool isImported;
  @override
  final String? loadoutHash;

  @override
  String toString() {
    return 'DraftLoadout(championId: $championId, playerId: $playerId, name: $name, loadoutCards: $loadoutCards, isImported: $isImported, loadoutHash: $loadoutHash)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DraftLoadout &&
            const DeepCollectionEquality()
                .equals(other.championId, championId) &&
            const DeepCollectionEquality().equals(other.playerId, playerId) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.loadoutCards, loadoutCards) &&
            const DeepCollectionEquality()
                .equals(other.isImported, isImported) &&
            const DeepCollectionEquality()
                .equals(other.loadoutHash, loadoutHash));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(championId),
      const DeepCollectionEquality().hash(playerId),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(loadoutCards),
      const DeepCollectionEquality().hash(isImported),
      const DeepCollectionEquality().hash(loadoutHash));

  @JsonKey(ignore: true)
  @override
  _$DraftLoadoutCopyWith<_DraftLoadout> get copyWith =>
      __$DraftLoadoutCopyWithImpl<_DraftLoadout>(this, _$identity);
}

abstract class _DraftLoadout implements DraftLoadout {
  factory _DraftLoadout(
      {required int championId,
      required String playerId,
      required String name,
      required List<LoadoutCard?> loadoutCards,
      required bool isImported,
      String? loadoutHash}) = _$_DraftLoadout;

  @override
  int get championId;
  @override
  String get playerId;
  @override
  String get name;
  @override
  List<LoadoutCard?> get loadoutCards;
  @override
  bool get isImported;
  @override
  String? get loadoutHash;
  @override
  @JsonKey(ignore: true)
  _$DraftLoadoutCopyWith<_DraftLoadout> get copyWith =>
      throw _privateConstructorUsedError;
}
