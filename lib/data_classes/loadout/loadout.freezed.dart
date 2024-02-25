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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
abstract class _$$LoadoutValidationResultImplCopyWith<$Res>
    implements $LoadoutValidationResultCopyWith<$Res> {
  factory _$$LoadoutValidationResultImplCopyWith(
          _$LoadoutValidationResultImpl value,
          $Res Function(_$LoadoutValidationResultImpl) then) =
      __$$LoadoutValidationResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool result, String error});
}

/// @nodoc
class __$$LoadoutValidationResultImplCopyWithImpl<$Res>
    extends _$LoadoutValidationResultCopyWithImpl<$Res,
        _$LoadoutValidationResultImpl>
    implements _$$LoadoutValidationResultImplCopyWith<$Res> {
  __$$LoadoutValidationResultImplCopyWithImpl(
      _$LoadoutValidationResultImpl _value,
      $Res Function(_$LoadoutValidationResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = null,
    Object? error = null,
  }) {
    return _then(_$LoadoutValidationResultImpl(
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

class _$LoadoutValidationResultImpl implements _LoadoutValidationResult {
  _$LoadoutValidationResultImpl({required this.result, required this.error});

  @override
  final bool result;
  @override
  final String error;

  @override
  String toString() {
    return 'LoadoutValidationResult(result: $result, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadoutValidationResultImpl &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadoutValidationResultImplCopyWith<_$LoadoutValidationResultImpl>
      get copyWith => __$$LoadoutValidationResultImplCopyWithImpl<
          _$LoadoutValidationResultImpl>(this, _$identity);
}

abstract class _LoadoutValidationResult implements LoadoutValidationResult {
  factory _LoadoutValidationResult(
      {required final bool result,
      required final String error}) = _$LoadoutValidationResultImpl;

  @override
  bool get result;
  @override
  String get error;
  @override
  @JsonKey(ignore: true)
  _$$LoadoutValidationResultImplCopyWith<_$LoadoutValidationResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}

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
      _$DraftLoadoutCopyWithImpl<$Res, DraftLoadout>;
  @useResult
  $Res call(
      {int championId,
      String playerId,
      String name,
      List<LoadoutCard?> loadoutCards,
      bool isImported,
      String? loadoutHash});
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
    Object? isImported = null,
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
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      loadoutCards: null == loadoutCards
          ? _value.loadoutCards
          : loadoutCards // ignore: cast_nullable_to_non_nullable
              as List<LoadoutCard?>,
      isImported: null == isImported
          ? _value.isImported
          : isImported // ignore: cast_nullable_to_non_nullable
              as bool,
      loadoutHash: freezed == loadoutHash
          ? _value.loadoutHash
          : loadoutHash // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DraftLoadoutImplCopyWith<$Res>
    implements $DraftLoadoutCopyWith<$Res> {
  factory _$$DraftLoadoutImplCopyWith(
          _$DraftLoadoutImpl value, $Res Function(_$DraftLoadoutImpl) then) =
      __$$DraftLoadoutImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int championId,
      String playerId,
      String name,
      List<LoadoutCard?> loadoutCards,
      bool isImported,
      String? loadoutHash});
}

/// @nodoc
class __$$DraftLoadoutImplCopyWithImpl<$Res>
    extends _$DraftLoadoutCopyWithImpl<$Res, _$DraftLoadoutImpl>
    implements _$$DraftLoadoutImplCopyWith<$Res> {
  __$$DraftLoadoutImplCopyWithImpl(
      _$DraftLoadoutImpl _value, $Res Function(_$DraftLoadoutImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? championId = null,
    Object? playerId = null,
    Object? name = null,
    Object? loadoutCards = null,
    Object? isImported = null,
    Object? loadoutHash = freezed,
  }) {
    return _then(_$DraftLoadoutImpl(
      championId: null == championId
          ? _value.championId
          : championId // ignore: cast_nullable_to_non_nullable
              as int,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      loadoutCards: null == loadoutCards
          ? _value._loadoutCards
          : loadoutCards // ignore: cast_nullable_to_non_nullable
              as List<LoadoutCard?>,
      isImported: null == isImported
          ? _value.isImported
          : isImported // ignore: cast_nullable_to_non_nullable
              as bool,
      loadoutHash: freezed == loadoutHash
          ? _value.loadoutHash
          : loadoutHash // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$DraftLoadoutImpl implements _DraftLoadout {
  _$DraftLoadoutImpl(
      {required this.championId,
      required this.playerId,
      required this.name,
      required final List<LoadoutCard?> loadoutCards,
      required this.isImported,
      this.loadoutHash})
      : _loadoutCards = loadoutCards;

  @override
  final int championId;
  @override
  final String playerId;
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
  final bool isImported;
  @override
  final String? loadoutHash;

  @override
  String toString() {
    return 'DraftLoadout(championId: $championId, playerId: $playerId, name: $name, loadoutCards: $loadoutCards, isImported: $isImported, loadoutHash: $loadoutHash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DraftLoadoutImpl &&
            (identical(other.championId, championId) ||
                other.championId == championId) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._loadoutCards, _loadoutCards) &&
            (identical(other.isImported, isImported) ||
                other.isImported == isImported) &&
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
      isImported,
      loadoutHash);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DraftLoadoutImplCopyWith<_$DraftLoadoutImpl> get copyWith =>
      __$$DraftLoadoutImplCopyWithImpl<_$DraftLoadoutImpl>(this, _$identity);
}

abstract class _DraftLoadout implements DraftLoadout {
  factory _DraftLoadout(
      {required final int championId,
      required final String playerId,
      required final String name,
      required final List<LoadoutCard?> loadoutCards,
      required final bool isImported,
      final String? loadoutHash}) = _$DraftLoadoutImpl;

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
  _$$DraftLoadoutImplCopyWith<_$DraftLoadoutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
