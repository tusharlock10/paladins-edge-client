import "package:freezed_annotation/freezed_annotation.dart";
import "package:paladinsedge/models/index.dart" show Ranked, MatchPlayerStats;

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
  PlayerTimedStats._();

  factory PlayerTimedStats({
    // type of timed stats
    required TimedStatsType timedStatsType,

    // for calculating rank diff
    required Ranked? rankedStart,
    required Ranked? rankedEnd,

    // count of played things
    required Map<String, int> queuesPlayed,
    required List<int> mostPlayedChampions,

    // matches data
    required int wins,
    required int losses,
    required Duration totalMatchesDuration,
    required MatchPlayerStats totalStats,
  }) = _PlayerTimedStats;

  int get totalMatches => wins + losses;
  num get damagePerMinute =>
      totalStats.totalDamageDealt / totalMatchesDuration.inMinutes;
  num get healingPerMinute =>
      totalStats.healingDone / totalMatchesDuration.inMinutes;
  MatchPlayerStats get averageStats => totalStats / totalMatches;
}
