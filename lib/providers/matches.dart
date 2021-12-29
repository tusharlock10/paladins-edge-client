import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;

class _MatchesNotifier extends ChangeNotifier {
  api.PlayerMatchesResponse? playerMatches;
  api.MatchDetailsResponse? matchDetails;
  List<api.PlayerDetailResponse?> players =
      []; // data of players to show in match

  Future<void> getPlayerMatches(String playerId) async {
    final response = await api.MatchRequests.playerMatches(playerId: playerId);
    if (response == null) return;
    playerMatches = response;

    notifyListeners();
  }

  void resetPlayerMatches() {
    playerMatches = null;
  }

  Future<void> getMatchDetails(String matchId) async {
    final response = await api.MatchRequests.matchDetails(matchId: matchId);
    if (response == null) return;
    matchDetails = response;

    notifyListeners();
  }

  Future<void> getPlayers(List<String> playerIds) async {
    final futures = playerIds.map(
      (playerId) {
        return api.PlayersRequests.playerDetail(
          playerId: playerId,
          forceUpdate: false,
        );
      },
    );

    players = await Future.wait(futures);

    notifyListeners();
  }

  void resetMatchDetails() {
    matchDetails = null;
    players = [];
  }
}

/// Provider to handle matches
final matches = ChangeNotifierProvider((_) => _MatchesNotifier());
