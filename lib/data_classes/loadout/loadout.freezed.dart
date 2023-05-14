// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loadout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
      _$LoadoutValidationResultCopyWithImpl<$Res, LoadoutValidationResult>;
  @useResult
  $Res call({bool result, String error});
}

/// @nodoc
class _$LoadoutValidationResultCopyWithImpl<$Res,
        $Val extends LoadoutValidationResult>
    implements $LoadoutValidationResultCopyWith<$Res> {
  _$LoadoutValidationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LoadoutValidationResultCopyWith<$Res>
    implements $LoadoutValidationResultCopyWith<$Res> {
  factory _$$_LoadoutValidationResultCopyWith(_$_LoadoutValidationResult value,
          $Res Function(_$_LoadoutValidationResult) then) =
      __$$_LoadoutValidationResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool result, String error});
}

/// @nodoc
class __$$_LoadoutValidationResultCopyWithImpl<$Res>
    extends _$LoadoutValidationResultCopyWithImpl<$Res,
        _$_LoadoutValidationResult>
    implements _$$_LoadoutValidationResultCopyWith<$Res> {
  __$$_LoadoutValidationResultCopyWithImpl(_$_LoadoutValidationResult _value,
      $Res Function(_$_LoadoutValidationResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = null,
    Object? error = null,
  }) {
    return _then(_$_LoadoutValidationResult(
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
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
            other is _$_LoadoutValidationResult &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoadoutValidationResultCopyWith<_$_LoadoutValidationResult>
      get copyWith =>
          __$$_LoadoutValidationResultCopyWithImpl<_$_LoadoutValidationResult>(
              this, _$identity);
}

abstract class _LoadoutValidationResult implements LoadoutValidationResult {
  factory _LoadoutValidationResult(
      {required final bool result,
      required final String error}) = _$_LoadoutValidationResult;

  @override
  bool get result;
  @override
  String get error;
  @override
  @JsonKey(ignore: true)
  _$$_LoadoutValidationResultCopyWith<_$_LoadoutValidationResult>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DraftLoadout {
  int get championId => throw _privateConstructorUsedError;
  int get playerId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<LoadoutCard?> get loadoutCards => throw _privateConstructorUsedError;
  bool get isPublic => throw _privateConstructorUsedError;
  int? get loadoutHash => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DraftLoadoutCopyWith<DraftLoadout> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DraftLoadoutCopyWith<$Res> {
  factory $DraftLoadoutCopyWith(
          DraftLoadout value, $Res Function(DraftLoadout) then) =
      _$DraftLoadoutCopyWithImpl<$Res, DraftLoadout>;
  @useResult
  $Res call(
      {int championId,
      int playerId,
      String name,
      List<LoadoutCard?> loadoutCards,
      bool isPublic,
      int? loadoutHash});
}

/// @nodoc
class _$DraftLoadoutCopyWithImpl<$Res, $Val extends DraftLoadout>
    implements $DraftLoadoutCopyWith<$Res> {
  _$DraftLoadoutCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? championId = null,
    Object? playerId = null,
    Object? name = null,
    Object? loadoutCards = null,
    Object? isPublic = null,
    Object? loadoutHash = freezed,
  }) {
    return _then(_value.copyWith(
      championId: null == championId
          ? _value.championId
          : championId // ignore: cast_nullable_to_non_nullable
              as int,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      loadoutCards: null == loadoutCards
          ? _value.loadoutCards
          : loadoutCards // ignore: cast_nullable_to_non_nullable
              as List<LoadoutCard?>,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      loadoutHash: freezed == loadoutHash
          ? _value.loadoutHash
          : loadoutHash // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DraftLoadoutCopyWith<$Res>
    implements $DraftLoadoutCopyWith<$Res> {
  factory _$$_DraftLoadoutCopyWith(
          _$_DraftLoadout value, $Res Function(_$_DraftLoadout) then) =
      __$$_DraftLoadoutCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int championId,
      int playerId,
      String name,
      List<LoadoutCard?> loadoutCards,
      bool isPublic,
      int? loadoutHash});
}

/// @nodoc
class __$$_DraftLoadoutCopyWithImpl<$Res>
    extends _$DraftLoadoutCopyWithImpl<$Res, _$_DraftLoadout>
    implements _$$_DraftLoadoutCopyWith<$Res> {
  __$$_DraftLoadoutCopyWithImpl(
      _$_DraftLoadout _value, $Res Function(_$_DraftLoadout) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? championId = null,
    Object? playerId = null,
    Object? name = null,
    Object? loadoutCards = null,
    Object? isPublic = null,
    Object? loadoutHash = freezed,
  }) {
    return _then(_$_DraftLoadout(
      championId: null == championId
          ? _value.championId
          : championId // ignore: cast_nullable_to_non_nullable
              as int,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      loadoutCards: null == loadoutCards
          ? _value._loadoutCards
          : loadoutCards // ignore: cast_nullable_to_non_nullable
              as List<LoadoutCard?>,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      loadoutHash: freezed == loadoutHash
          ? _value.loadoutHash
          : loadoutHash // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_DraftLoadout implements _DraftLoadout {
  _$_DraftLoadout(
      {required this.championId,
      required this.playerId,
      required this.name,
      required final List<LoadoutCard?> loadoutCards,
      required this.isPublic,
      this.loadoutHash})
      : _loadoutCards = loadoutCards;

  @override
  final int championId;
  @override
  final int playerId;
  @override
  final String name;
  final List<LoadoutCard?> _loadoutCards;
  @override
  List<LoadoutCard?> get loadoutCards {
    if (_loadoutCards is EqualUnmodifiableListView) return _loadoutCards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_loadoutCards);
  }

  @override
  final bool isPublic;
  @override
  final int? loadoutHash;

  @override
  String toString() {
    return 'DraftLoadout(championId: $championId, playerId: $playerId, name: $name, loadoutCards: $loadoutCards, isPublic: $isPublic, loadoutHash: $loadoutHash)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DraftLoadout &&
            (identical(other.championId, championId) ||
                other.championId == championId) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._loadoutCards, _loadoutCards) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.loadoutHash, loadoutHash) ||
                other.loadoutHash == loadoutHash));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      championId,
      playerId,
      name,
      const DeepCollectionEquality().hash(_loadoutCards),
      isPublic,
      loadoutHash);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DraftLoadoutCopyWith<_$_DraftLoadout> get copyWith =>
      __$$_DraftLoadoutCopyWithImpl<_$_DraftLoadout>(this, _$identity);
}

abstract class _DraftLoadout implements DraftLoadout {
  factory _DraftLoadout(
      {required final int championId,
      required final int playerId,
      required final String name,
      required final List<LoadoutCard?> loadoutCards,
      required final bool isPublic,
      final int? loadoutHash}) = _$_DraftLoadout;

  @override
  int get championId;
  @override
  int get playerId;
  @override
  String get name;
  @override
  List<LoadoutCard?> get loadoutCards;
  @override
  bool get isPublic;
  @override
  int? get loadoutHash;
  @override
  @JsonKey(ignore: true)
  _$$_DraftLoadoutCopyWith<_$_DraftLoadout> get copyWith =>
      throw _privateConstructorUsedError;
}
