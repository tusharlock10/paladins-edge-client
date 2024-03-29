// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'combined_champion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
      _$CombinedChampionCopyWithImpl<$Res, CombinedChampion>;
  @useResult
  $Res call(
      {Champion champion,
      PlayerChampion? playerChampion,
      bool hide,
      ChampionsSearchCondition? searchCondition});
}

/// @nodoc
class _$CombinedChampionCopyWithImpl<$Res, $Val extends CombinedChampion>
    implements $CombinedChampionCopyWith<$Res> {
  _$CombinedChampionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? champion = null,
    Object? playerChampion = freezed,
    Object? hide = null,
    Object? searchCondition = freezed,
  }) {
    return _then(_value.copyWith(
      champion: null == champion
          ? _value.champion
          : champion // ignore: cast_nullable_to_non_nullable
              as Champion,
      playerChampion: freezed == playerChampion
          ? _value.playerChampion
          : playerChampion // ignore: cast_nullable_to_non_nullable
              as PlayerChampion?,
      hide: null == hide
          ? _value.hide
          : hide // ignore: cast_nullable_to_non_nullable
              as bool,
      searchCondition: freezed == searchCondition
          ? _value.searchCondition
          : searchCondition // ignore: cast_nullable_to_non_nullable
              as ChampionsSearchCondition?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CombinedChampionImplCopyWith<$Res>
    implements $CombinedChampionCopyWith<$Res> {
  factory _$$CombinedChampionImplCopyWith(_$CombinedChampionImpl value,
          $Res Function(_$CombinedChampionImpl) then) =
      __$$CombinedChampionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Champion champion,
      PlayerChampion? playerChampion,
      bool hide,
      ChampionsSearchCondition? searchCondition});
}

/// @nodoc
class __$$CombinedChampionImplCopyWithImpl<$Res>
    extends _$CombinedChampionCopyWithImpl<$Res, _$CombinedChampionImpl>
    implements _$$CombinedChampionImplCopyWith<$Res> {
  __$$CombinedChampionImplCopyWithImpl(_$CombinedChampionImpl _value,
      $Res Function(_$CombinedChampionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? champion = null,
    Object? playerChampion = freezed,
    Object? hide = null,
    Object? searchCondition = freezed,
  }) {
    return _then(_$CombinedChampionImpl(
      champion: null == champion
          ? _value.champion
          : champion // ignore: cast_nullable_to_non_nullable
              as Champion,
      playerChampion: freezed == playerChampion
          ? _value.playerChampion
          : playerChampion // ignore: cast_nullable_to_non_nullable
              as PlayerChampion?,
      hide: null == hide
          ? _value.hide
          : hide // ignore: cast_nullable_to_non_nullable
              as bool,
      searchCondition: freezed == searchCondition
          ? _value.searchCondition
          : searchCondition // ignore: cast_nullable_to_non_nullable
              as ChampionsSearchCondition?,
    ));
  }
}

/// @nodoc

class _$CombinedChampionImpl implements _CombinedChampion {
  _$CombinedChampionImpl(
      {required this.champion,
      this.playerChampion,
      this.hide = false,
      this.searchCondition = null});

  @override
  final Champion champion;
  @override
  final PlayerChampion? playerChampion;
  @override
  @JsonKey()
  final bool hide;
// used for filtering
  @override
  @JsonKey()
  final ChampionsSearchCondition? searchCondition;

  @override
  String toString() {
    return 'CombinedChampion(champion: $champion, playerChampion: $playerChampion, hide: $hide, searchCondition: $searchCondition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CombinedChampionImpl &&
            (identical(other.champion, champion) ||
                other.champion == champion) &&
            (identical(other.playerChampion, playerChampion) ||
                other.playerChampion == playerChampion) &&
            (identical(other.hide, hide) || other.hide == hide) &&
            (identical(other.searchCondition, searchCondition) ||
                other.searchCondition == searchCondition));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, champion, playerChampion, hide, searchCondition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CombinedChampionImplCopyWith<_$CombinedChampionImpl> get copyWith =>
      __$$CombinedChampionImplCopyWithImpl<_$CombinedChampionImpl>(
          this, _$identity);
}

abstract class _CombinedChampion implements CombinedChampion {
  factory _CombinedChampion(
          {required final Champion champion,
          final PlayerChampion? playerChampion,
          final bool hide,
          final ChampionsSearchCondition? searchCondition}) =
      _$CombinedChampionImpl;

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
  _$$CombinedChampionImplCopyWith<_$CombinedChampionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
