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
// type of timed stats
  TimedStatsType get timedStatsType =>
      throw _privateConstructorUsedError; // for calculating rank diff
  Ranked? get rankedStart => throw _privateConstructorUsedError;
  Ranked? get rankedEnd =>
      throw _privateConstructorUsedError; // count of played things
  Map<String, int> get queuesPlayed => throw _privateConstructorUsedError;
  List<int> get mostPlayedChampions =>
      throw _privateConstructorUsedError; // matches data
  int get wins => throw _privateConstructorUsedError;
  int get losses => throw _privateConstructorUsedError;
  Duration get totalMatchesDuration => throw _privateConstructorUsedError;
  MatchPlayerStats get totalStats => throw _privateConstructorUsedError;

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
      Ranked? rankedStart,
      Ranked? rankedEnd,
      Map<String, int> queuesPlayed,
      List<int> mostPlayedChampions,
      int wins,
      int losses,
      Duration totalMatchesDuration,
      MatchPlayerStats totalStats});
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
    Object? rankedStart = freezed,
    Object? rankedEnd = freezed,
    Object? queuesPlayed = null,
    Object? mostPlayedChampions = null,
    Object? wins = null,
    Object? losses = null,
    Object? totalMatchesDuration = null,
    Object? totalStats = null,
  }) {
    return _then(_value.copyWith(
      timedStatsType: null == timedStatsType
          ? _value.timedStatsType
          : timedStatsType // ignore: cast_nullable_to_non_nullable
              as TimedStatsType,
      rankedStart: freezed == rankedStart
          ? _value.rankedStart
          : rankedStart // ignore: cast_nullable_to_non_nullable
              as Ranked?,
      rankedEnd: freezed == rankedEnd
          ? _value.rankedEnd
          : rankedEnd // ignore: cast_nullable_to_non_nullable
              as Ranked?,
      queuesPlayed: null == queuesPlayed
          ? _value.queuesPlayed
          : queuesPlayed // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      mostPlayedChampions: null == mostPlayedChampions
          ? _value.mostPlayedChampions
          : mostPlayedChampions // ignore: cast_nullable_to_non_nullable
              as List<int>,
      wins: null == wins
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      losses: null == losses
          ? _value.losses
          : losses // ignore: cast_nullable_to_non_nullable
              as int,
      totalMatchesDuration: null == totalMatchesDuration
          ? _value.totalMatchesDuration
          : totalMatchesDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      totalStats: null == totalStats
          ? _value.totalStats
          : totalStats // ignore: cast_nullable_to_non_nullable
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
      Ranked? rankedStart,
      Ranked? rankedEnd,
      Map<String, int> queuesPlayed,
      List<int> mostPlayedChampions,
      int wins,
      int losses,
      Duration totalMatchesDuration,
      MatchPlayerStats totalStats});
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
    Object? rankedStart = freezed,
    Object? rankedEnd = freezed,
    Object? queuesPlayed = null,
    Object? mostPlayedChampions = null,
    Object? wins = null,
    Object? losses = null,
    Object? totalMatchesDuration = null,
    Object? totalStats = null,
  }) {
    return _then(_$PlayerTimedStatsImpl(
      timedStatsType: null == timedStatsType
          ? _value.timedStatsType
          : timedStatsType // ignore: cast_nullable_to_non_nullable
              as TimedStatsType,
      rankedStart: freezed == rankedStart
          ? _value.rankedStart
          : rankedStart // ignore: cast_nullable_to_non_nullable
              as Ranked?,
      rankedEnd: freezed == rankedEnd
          ? _value.rankedEnd
          : rankedEnd // ignore: cast_nullable_to_non_nullable
              as Ranked?,
      queuesPlayed: null == queuesPlayed
          ? _value._queuesPlayed
          : queuesPlayed // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      mostPlayedChampions: null == mostPlayedChampions
          ? _value._mostPlayedChampions
          : mostPlayedChampions // ignore: cast_nullable_to_non_nullable
              as List<int>,
      wins: null == wins
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      losses: null == losses
          ? _value.losses
          : losses // ignore: cast_nullable_to_non_nullable
              as int,
      totalMatchesDuration: null == totalMatchesDuration
          ? _value.totalMatchesDuration
          : totalMatchesDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      totalStats: null == totalStats
          ? _value.totalStats
          : totalStats // ignore: cast_nullable_to_non_nullable
              as MatchPlayerStats,
    ));
  }
}

/// @nodoc

class _$PlayerTimedStatsImpl extends _PlayerTimedStats {
  _$PlayerTimedStatsImpl(
      {required this.timedStatsType,
      required this.rankedStart,
      required this.rankedEnd,
      required final Map<String, int> queuesPlayed,
      required final List<int> mostPlayedChampions,
      required this.wins,
      required this.losses,
      required this.totalMatchesDuration,
      required this.totalStats})
      : _queuesPlayed = queuesPlayed,
        _mostPlayedChampions = mostPlayedChampions,
        super._();

// type of timed stats
  @override
  final TimedStatsType timedStatsType;
// for calculating rank diff
  @override
  final Ranked? rankedStart;
  @override
  final Ranked? rankedEnd;
// count of played things
  final Map<String, int> _queuesPlayed;
// count of played things
  @override
  Map<String, int> get queuesPlayed {
    if (_queuesPlayed is EqualUnmodifiableMapView) return _queuesPlayed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_queuesPlayed);
  }

  final List<int> _mostPlayedChampions;
  @override
  List<int> get mostPlayedChampions {
    if (_mostPlayedChampions is EqualUnmodifiableListView)
      return _mostPlayedChampions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mostPlayedChampions);
  }

// matches data
  @override
  final int wins;
  @override
  final int losses;
  @override
  final Duration totalMatchesDuration;
  @override
  final MatchPlayerStats totalStats;

  @override
  String toString() {
    return 'PlayerTimedStats(timedStatsType: $timedStatsType, rankedStart: $rankedStart, rankedEnd: $rankedEnd, queuesPlayed: $queuesPlayed, mostPlayedChampions: $mostPlayedChampions, wins: $wins, losses: $losses, totalMatchesDuration: $totalMatchesDuration, totalStats: $totalStats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerTimedStatsImpl &&
            (identical(other.timedStatsType, timedStatsType) ||
                other.timedStatsType == timedStatsType) &&
            (identical(other.rankedStart, rankedStart) ||
                other.rankedStart == rankedStart) &&
            (identical(other.rankedEnd, rankedEnd) ||
                other.rankedEnd == rankedEnd) &&
            const DeepCollectionEquality()
                .equals(other._queuesPlayed, _queuesPlayed) &&
            const DeepCollectionEquality()
                .equals(other._mostPlayedChampions, _mostPlayedChampions) &&
            (identical(other.wins, wins) || other.wins == wins) &&
            (identical(other.losses, losses) || other.losses == losses) &&
            (identical(other.totalMatchesDuration, totalMatchesDuration) ||
                other.totalMatchesDuration == totalMatchesDuration) &&
            (identical(other.totalStats, totalStats) ||
                other.totalStats == totalStats));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      timedStatsType,
      rankedStart,
      rankedEnd,
      const DeepCollectionEquality().hash(_queuesPlayed),
      const DeepCollectionEquality().hash(_mostPlayedChampions),
      wins,
      losses,
      totalMatchesDuration,
      totalStats);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerTimedStatsImplCopyWith<_$PlayerTimedStatsImpl> get copyWith =>
      __$$PlayerTimedStatsImplCopyWithImpl<_$PlayerTimedStatsImpl>(
          this, _$identity);
}

abstract class _PlayerTimedStats extends PlayerTimedStats {
  factory _PlayerTimedStats(
      {required final TimedStatsType timedStatsType,
      required final Ranked? rankedStart,
      required final Ranked? rankedEnd,
      required final Map<String, int> queuesPlayed,
      required final List<int> mostPlayedChampions,
      required final int wins,
      required final int losses,
      required final Duration totalMatchesDuration,
      required final MatchPlayerStats totalStats}) = _$PlayerTimedStatsImpl;
  _PlayerTimedStats._() : super._();

  @override // type of timed stats
  TimedStatsType get timedStatsType;
  @override // for calculating rank diff
  Ranked? get rankedStart;
  @override
  Ranked? get rankedEnd;
  @override // count of played things
  Map<String, int> get queuesPlayed;
  @override
  List<int> get mostPlayedChampions;
  @override // matches data
  int get wins;
  @override
  int get losses;
  @override
  Duration get totalMatchesDuration;
  @override
  MatchPlayerStats get totalStats;
  @override
  @JsonKey(ignore: true)
  _$$PlayerTimedStatsImplCopyWith<_$PlayerTimedStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
