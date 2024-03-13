// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_timed_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PlayerTimedStats {
  TimedStatsType get timedStatsType =>
      throw _privateConstructorUsedError; // for calculating rank diff
  BaseRank get startingRank => throw _privateConstructorUsedError;
  BaseRank get endingRank =>
      throw _privateConstructorUsedError; // per match data
  Map<String, int> get matchesType =>
      throw _privateConstructorUsedError; // average matches data
  int get totalMatches => throw _privateConstructorUsedError;
  int get wins => throw _privateConstructorUsedError;
  int get losses => throw _privateConstructorUsedError;
  MatchPlayerStats get averageStats => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayerTimedStatsCopyWith<PlayerTimedStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerTimedStatsCopyWith<$Res> {
  factory $PlayerTimedStatsCopyWith(
          PlayerTimedStats value, $Res Function(PlayerTimedStats) then) =
      _$PlayerTimedStatsCopyWithImpl<$Res, PlayerTimedStats>;
  @useResult
  $Res call(
      {TimedStatsType timedStatsType,
      BaseRank startingRank,
      BaseRank endingRank,
      Map<String, int> matchesType,
      int totalMatches,
      int wins,
      int losses,
      MatchPlayerStats averageStats});
}

/// @nodoc
class _$PlayerTimedStatsCopyWithImpl<$Res, $Val extends PlayerTimedStats>
    implements $PlayerTimedStatsCopyWith<$Res> {
  _$PlayerTimedStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timedStatsType = null,
    Object? startingRank = null,
    Object? endingRank = null,
    Object? matchesType = null,
    Object? totalMatches = null,
    Object? wins = null,
    Object? losses = null,
    Object? averageStats = null,
  }) {
    return _then(_value.copyWith(
      timedStatsType: null == timedStatsType
          ? _value.timedStatsType
          : timedStatsType // ignore: cast_nullable_to_non_nullable
              as TimedStatsType,
      startingRank: null == startingRank
          ? _value.startingRank
          : startingRank // ignore: cast_nullable_to_non_nullable
              as BaseRank,
      endingRank: null == endingRank
          ? _value.endingRank
          : endingRank // ignore: cast_nullable_to_non_nullable
              as BaseRank,
      matchesType: null == matchesType
          ? _value.matchesType
          : matchesType // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      totalMatches: null == totalMatches
          ? _value.totalMatches
          : totalMatches // ignore: cast_nullable_to_non_nullable
              as int,
      wins: null == wins
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      losses: null == losses
          ? _value.losses
          : losses // ignore: cast_nullable_to_non_nullable
              as int,
      averageStats: null == averageStats
          ? _value.averageStats
          : averageStats // ignore: cast_nullable_to_non_nullable
              as MatchPlayerStats,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerTimedStatsImplCopyWith<$Res>
    implements $PlayerTimedStatsCopyWith<$Res> {
  factory _$$PlayerTimedStatsImplCopyWith(_$PlayerTimedStatsImpl value,
          $Res Function(_$PlayerTimedStatsImpl) then) =
      __$$PlayerTimedStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TimedStatsType timedStatsType,
      BaseRank startingRank,
      BaseRank endingRank,
      Map<String, int> matchesType,
      int totalMatches,
      int wins,
      int losses,
      MatchPlayerStats averageStats});
}

/// @nodoc
class __$$PlayerTimedStatsImplCopyWithImpl<$Res>
    extends _$PlayerTimedStatsCopyWithImpl<$Res, _$PlayerTimedStatsImpl>
    implements _$$PlayerTimedStatsImplCopyWith<$Res> {
  __$$PlayerTimedStatsImplCopyWithImpl(_$PlayerTimedStatsImpl _value,
      $Res Function(_$PlayerTimedStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timedStatsType = null,
    Object? startingRank = null,
    Object? endingRank = null,
    Object? matchesType = null,
    Object? totalMatches = null,
    Object? wins = null,
    Object? losses = null,
    Object? averageStats = null,
  }) {
    return _then(_$PlayerTimedStatsImpl(
      timedStatsType: null == timedStatsType
          ? _value.timedStatsType
          : timedStatsType // ignore: cast_nullable_to_non_nullable
              as TimedStatsType,
      startingRank: null == startingRank
          ? _value.startingRank
          : startingRank // ignore: cast_nullable_to_non_nullable
              as BaseRank,
      endingRank: null == endingRank
          ? _value.endingRank
          : endingRank // ignore: cast_nullable_to_non_nullable
              as BaseRank,
      matchesType: null == matchesType
          ? _value._matchesType
          : matchesType // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      totalMatches: null == totalMatches
          ? _value.totalMatches
          : totalMatches // ignore: cast_nullable_to_non_nullable
              as int,
      wins: null == wins
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      losses: null == losses
          ? _value.losses
          : losses // ignore: cast_nullable_to_non_nullable
              as int,
      averageStats: null == averageStats
          ? _value.averageStats
          : averageStats // ignore: cast_nullable_to_non_nullable
              as MatchPlayerStats,
    ));
  }
}

/// @nodoc

class _$PlayerTimedStatsImpl implements _PlayerTimedStats {
  _$PlayerTimedStatsImpl(
      {required this.timedStatsType,
      required this.startingRank,
      required this.endingRank,
      required final Map<String, int> matchesType,
      required this.totalMatches,
      required this.wins,
      required this.losses,
      required this.averageStats})
      : _matchesType = matchesType;

  @override
  final TimedStatsType timedStatsType;
// for calculating rank diff
  @override
  final BaseRank startingRank;
  @override
  final BaseRank endingRank;
// per match data
  final Map<String, int> _matchesType;
// per match data
  @override
  Map<String, int> get matchesType {
    if (_matchesType is EqualUnmodifiableMapView) return _matchesType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_matchesType);
  }

// average matches data
  @override
  final int totalMatches;
  @override
  final int wins;
  @override
  final int losses;
  @override
  final MatchPlayerStats averageStats;

  @override
  String toString() {
    return 'PlayerTimedStats(timedStatsType: $timedStatsType, startingRank: $startingRank, endingRank: $endingRank, matchesType: $matchesType, totalMatches: $totalMatches, wins: $wins, losses: $losses, averageStats: $averageStats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerTimedStatsImpl &&
            (identical(other.timedStatsType, timedStatsType) ||
                other.timedStatsType == timedStatsType) &&
            (identical(other.startingRank, startingRank) ||
                other.startingRank == startingRank) &&
            (identical(other.endingRank, endingRank) ||
                other.endingRank == endingRank) &&
            const DeepCollectionEquality()
                .equals(other._matchesType, _matchesType) &&
            (identical(other.totalMatches, totalMatches) ||
                other.totalMatches == totalMatches) &&
            (identical(other.wins, wins) || other.wins == wins) &&
            (identical(other.losses, losses) || other.losses == losses) &&
            (identical(other.averageStats, averageStats) ||
                other.averageStats == averageStats));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      timedStatsType,
      startingRank,
      endingRank,
      const DeepCollectionEquality().hash(_matchesType),
      totalMatches,
      wins,
      losses,
      averageStats);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerTimedStatsImplCopyWith<_$PlayerTimedStatsImpl> get copyWith =>
      __$$PlayerTimedStatsImplCopyWithImpl<_$PlayerTimedStatsImpl>(
          this, _$identity);
}

abstract class _PlayerTimedStats implements PlayerTimedStats {
  factory _PlayerTimedStats(
      {required final TimedStatsType timedStatsType,
      required final BaseRank startingRank,
      required final BaseRank endingRank,
      required final Map<String, int> matchesType,
      required final int totalMatches,
      required final int wins,
      required final int losses,
      required final MatchPlayerStats averageStats}) = _$PlayerTimedStatsImpl;

  @override
  TimedStatsType get timedStatsType;
  @override // for calculating rank diff
  BaseRank get startingRank;
  @override
  BaseRank get endingRank;
  @override // per match data
  Map<String, int> get matchesType;
  @override // average matches data
  int get totalMatches;
  @override
  int get wins;
  @override
  int get losses;
  @override
  MatchPlayerStats get averageStats;
  @override
  @JsonKey(ignore: true)
  _$$PlayerTimedStatsImplCopyWith<_$PlayerTimedStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
