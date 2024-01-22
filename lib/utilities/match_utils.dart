import "package:dartx/dartx.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;

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
