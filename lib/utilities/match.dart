import "package:dartx/dartx.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;

bool isTrainingMatch(models.Match match) {
  return match.queue.contains("Training");
}

models.MatchPlayer? getMatchPlayerFromPlayerId(
  List<models.MatchPlayer> matchPlayers,
  String? playerId,
) {
  if (playerId == null) return null;

  return matchPlayers.firstOrNullWhere((_) => _.playerId == playerId);
}

bool didPlayerWin(
  data_classes.CombinedMatch combinedMatch,
  String playerId, {
  models.MatchPlayer? matchPlayer,
}) {
  final usableMatchPlayer = matchPlayer ??
      getMatchPlayerFromPlayerId(combinedMatch.matchPlayers, playerId);
  if (usableMatchPlayer == null) return false;

  return usableMatchPlayer.team == combinedMatch.match.winningTeam;
}

/// get the winning/ loosing streak of the player,
/// assuming `combinedMatches` is sorted by date
int? getPlayerStreak(
  List<data_classes.CombinedMatch> combinedMatches,
  String? combinedMatchesPlayerId,
) {
  if (combinedMatches.length < 5) return null;
  if (combinedMatchesPlayerId == null) return null;

  final playerId = combinedMatchesPlayerId;
  final firstCombinedMatch = combinedMatches.first;
  final isFirstWin = didPlayerWin(firstCombinedMatch, playerId);
  int streak = 1;

  for (final combinedMatch in combinedMatches.skip(1)) {
    if (isTrainingMatch(combinedMatch.match)) continue;

    final isWin = didPlayerWin(combinedMatch, playerId);
    if (isFirstWin == isWin) {
      streak++;
    } else {
      break;
    }
  }
  if (streak < 3) return null;

  return isFirstWin ? streak : -streak;
}

/// get the timed stats of the player,
/// assuming `combinedMatches` is sorted by date
data_classes.PlayerTimedStats getPlayerTimedStats(
  List<data_classes.CombinedMatch> combinedMatches,
  data_classes.TimedStatsType timedStatsType,
  String playerId,
) {
  final earliestDate = DateTime.now() -
      data_classes.TimedStatsValues.durationValues[timedStatsType]!;

  models.Ranked? rankedStart;
  models.Ranked? rankedEnd = getMatchPlayerFromPlayerId(
    combinedMatches.first.matchPlayers,
    playerId,
  )?.playerRanked;
  Map<String, int> queuesPlayed = {};
  Map<int, int> championsPlayed = {};
  int wins = 0;
  int losses = 0;
  Duration totalMatchesDuration = Duration.zero;
  models.MatchPlayerStats totalStats = models.MatchPlayerStats.createEmpty();

  for (final combinedMatch in combinedMatches) {
    // assuming matches are sorted by date, we can safely break the loop
    // upon encountering an earlier than expected match
    if (combinedMatch.match.matchStartTime < earliestDate) break;

    final matchPlayer = getMatchPlayerFromPlayerId(
      combinedMatch.matchPlayers,
      playerId,
    );
    if (matchPlayer == null) continue;

    rankedStart = matchPlayer.playerRanked;
    queuesPlayed.update(
      combinedMatch.match.queue,
      (count) => count + 1,
      ifAbsent: () => 0,
    );
    championsPlayed.update(
      matchPlayer.championId,
      (count) => count + 1,
      ifAbsent: () => 0,
    );
    if (didPlayerWin(combinedMatch, playerId, matchPlayer: matchPlayer)) {
      wins += 1;
    } else {
      losses += 1;
    }
    totalStats += matchPlayer.playerStats;
    totalMatchesDuration += combinedMatch.match.matchDuration;
  }

  final mostPlayedChampions =
      championsPlayed.keys.sortedDescending().takeFirst(3);

  return data_classes.PlayerTimedStats(
    timedStatsType: timedStatsType,
    rankedStart: rankedStart,
    rankedEnd: rankedEnd,
    queuesPlayed: queuesPlayed,
    mostPlayedChampions: mostPlayedChampions,
    totalMatchesDuration: totalMatchesDuration,
    wins: wins,
    losses: losses,
    totalStats: totalStats,
  );
}
