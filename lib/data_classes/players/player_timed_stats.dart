import "package:freezed_annotation/freezed_annotation.dart";
import "package:paladinsedge/models/index.dart" show BaseRank, MatchPlayerStats;

part "player_timed_stats.freezed.dart";

enum TimedStatsType { days1, days7, days30 }

abstract class TimedStatsValues {
  static const durationNames = {
    TimedStatsType.days1: "Today",
    TimedStatsType.days7: "Last 7 Days",
    TimedStatsType.days30: "Last 30 Days",
  };

  static const durationValues = {
    TimedStatsType.days1: Duration(days: 1),
    TimedStatsType.days7: Duration(days: 7),
    TimedStatsType.days30: Duration(days: 30),
  };
}

@freezed
class PlayerTimedStats with _$PlayerTimedStats {
  factory PlayerTimedStats({
    required TimedStatsType timedStatsType,

    // for calculating rank diff
    required BaseRank startingRank,
    required BaseRank endingRank,

    // per match data
    required Map<String, int> matchesType,

    // average matches data
    required int totalMatches,
    required int wins,
    required int losses,
    required MatchPlayerStats averageStats,
  }) = _PlayerTimedStats;
}
