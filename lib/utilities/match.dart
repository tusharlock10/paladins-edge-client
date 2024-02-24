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
  String playerId,
) {
  final matchPlayer =
      getMatchPlayerFromPlayerId(combinedMatch.matchPlayers, playerId);
  if (matchPlayer == null) return false;

  return matchPlayer.team == combinedMatch.match.winningTeam;
}

int? getPlayerStreak(
  List<data_classes.CombinedMatch>? combinedMatches,
  String? combinedMatchesPlayerId,
) {
  if (combinedMatches == null) return null;
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
