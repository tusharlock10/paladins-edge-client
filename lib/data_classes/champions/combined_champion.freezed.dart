// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'combined_champion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CombinedChampionTearOff {
  const _$CombinedChampionTearOff();

  _CombinedChampion call(
      {required Champion champion,
      PlayerChampion? playerChampion,
      bool hide = false,
      ChampionsSearchCondition? searchCondition = null}) {
    return _CombinedChampion(
      champion: champion,
      playerChampion: playerChampion,
      hide: hide,
      searchCondition: searchCondition,
    );
  }
}

/// @nodoc
const $CombinedChampion = _$CombinedChampionTearOff();

/// @nodoc
mixin _$CombinedChampion {
  Champion get champion => throw _privateConstructorUsedError;
  PlayerChampion? get playerChampion => throw _privateConstructorUsedError;
  bool get hide => throw _privateConstructorUsedError; // used for filtering
  ChampionsSearchCondition? get searchCondition =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CombinedChampionCopyWith<CombinedChampion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CombinedChampionCopyWith<$Res> {
  factory $CombinedChampionCopyWith(
          CombinedChampion value, $Res Function(CombinedChampion) then) =
      _$CombinedChampionCopyWithImpl<$Res>;
  $Res call(
      {Champion champion,
      PlayerChampion? playerChampion,
      bool hide,
      ChampionsSearchCondition? searchCondition});
}

/// @nodoc
class _$CombinedChampionCopyWithImpl<$Res>
    implements $CombinedChampionCopyWith<$Res> {
  _$CombinedChampionCopyWithImpl(this._value, this._then);

  final CombinedChampion _value;
  // ignore: unused_field
  final $Res Function(CombinedChampion) _then;

  @override
  $Res call({
    Object? champion = freezed,
    Object? playerChampion = freezed,
    Object? hide = freezed,
    Object? searchCondition = freezed,
  }) {
    return _then(_value.copyWith(
      champion: champion == freezed
          ? _value.champion
          : champion // ignore: cast_nullable_to_non_nullable
              as Champion,
      playerChampion: playerChampion == freezed
          ? _value.playerChampion
          : playerChampion // ignore: cast_nullable_to_non_nullable
              as PlayerChampion?,
      hide: hide == freezed
          ? _value.hide
          : hide // ignore: cast_nullable_to_non_nullable
              as bool,
      searchCondition: searchCondition == freezed
          ? _value.searchCondition
          : searchCondition // ignore: cast_nullable_to_non_nullable
              as ChampionsSearchCondition?,
    ));
  }
}

/// @nodoc
abstract class _$CombinedChampionCopyWith<$Res>
    implements $CombinedChampionCopyWith<$Res> {
  factory _$CombinedChampionCopyWith(
          _CombinedChampion value, $Res Function(_CombinedChampion) then) =
      __$CombinedChampionCopyWithImpl<$Res>;
  @override
  $Res call(
      {Champion champion,
      PlayerChampion? playerChampion,
      bool hide,
      ChampionsSearchCondition? searchCondition});
}

/// @nodoc
class __$CombinedChampionCopyWithImpl<$Res>
    extends _$CombinedChampionCopyWithImpl<$Res>
    implements _$CombinedChampionCopyWith<$Res> {
  __$CombinedChampionCopyWithImpl(
      _CombinedChampion _value, $Res Function(_CombinedChampion) _then)
      : super(_value, (v) => _then(v as _CombinedChampion));

  @override
  _CombinedChampion get _value => super._value as _CombinedChampion;

  @override
  $Res call({
    Object? champion = freezed,
    Object? playerChampion = freezed,
    Object? hide = freezed,
    Object? searchCondition = freezed,
  }) {
    return _then(_CombinedChampion(
      champion: champion == freezed
          ? _value.champion
          : champion // ignore: cast_nullable_to_non_nullable
              as Champion,
      playerChampion: playerChampion == freezed
          ? _value.playerChampion
          : playerChampion // ignore: cast_nullable_to_non_nullable
              as PlayerChampion?,
      hide: hide == freezed
          ? _value.hide
          : hide // ignore: cast_nullable_to_non_nullable
              as bool,
      searchCondition: searchCondition == freezed
          ? _value.searchCondition
          : searchCondition // ignore: cast_nullable_to_non_nullable
              as ChampionsSearchCondition?,
    ));
  }
}

/// @nodoc

class _$_CombinedChampion implements _CombinedChampion {
  _$_CombinedChampion(
      {required this.champion,
      this.playerChampion,
      this.hide = false,
      this.searchCondition = null});

  @override
  final Champion champion;
  @override
  final PlayerChampion? playerChampion;
  @JsonKey()
  @override
  final bool hide;
  @JsonKey()
  @override // used for filtering
  final ChampionsSearchCondition? searchCondition;

  @override
  String toString() {
    return 'CombinedChampion(champion: $champion, playerChampion: $playerChampion, hide: $hide, searchCondition: $searchCondition)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CombinedChampion &&
            const DeepCollectionEquality().equals(other.champion, champion) &&
            const DeepCollectionEquality()
                .equals(other.playerChampion, playerChampion) &&
            const DeepCollectionEquality().equals(other.hide, hide) &&
            const DeepCollectionEquality()
                .equals(other.searchCondition, searchCondition));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(champion),
      const DeepCollectionEquality().hash(playerChampion),
      const DeepCollectionEquality().hash(hide),
      const DeepCollectionEquality().hash(searchCondition));

  @JsonKey(ignore: true)
  @override
  _$CombinedChampionCopyWith<_CombinedChampion> get copyWith =>
      __$CombinedChampionCopyWithImpl<_CombinedChampion>(this, _$identity);
}

abstract class _CombinedChampion implements CombinedChampion {
  factory _CombinedChampion(
      {required Champion champion,
      PlayerChampion? playerChampion,
      bool hide,
      ChampionsSearchCondition? searchCondition}) = _$_CombinedChampion;

  @override
  Champion get champion;
  @override
  PlayerChampion? get playerChampion;
  @override
  bool get hide;
  @override // used for filtering
  ChampionsSearchCondition? get searchCondition;
  @override
  @JsonKey(ignore: true)
  _$CombinedChampionCopyWith<_CombinedChampion> get copyWith =>
      throw _privateConstructorUsedError;
}
