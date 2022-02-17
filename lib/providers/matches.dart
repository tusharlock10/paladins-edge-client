import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class _MatchesNotifier extends ChangeNotifier {
  bool isPlayerMatchesLoading = false;
  bool isMatchDetailsLoading = false;
  api.PlayerMatchesResponse? playerMatches;
  api.MatchDetailsResponse? matchDetails;

  Future<void> getPlayerMatches(String playerId) async {
    isPlayerMatchesLoading = true;
    utilities.postFrameCallback(notifyListeners);

    final response = await api.MatchRequests.playerMatches(playerId: playerId);

    isPlayerMatchesLoading = false;
    playerMatches = response;

    utilities.postFrameCallback(notifyListeners);
  }

  void resetPlayerMatches() {
    playerMatches = null;

    utilities.postFrameCallback(notifyListeners);
  }

  Future<void> getMatchDetails(String matchId) async {
    isMatchDetailsLoading = true;
    utilities.postFrameCallback(notifyListeners);

    final response = await api.MatchRequests.matchDetails(matchId: matchId);

    isMatchDetailsLoading = false;
    matchDetails = response;

    // sort players based on their team
    matchDetails?.matchPlayers.sort((a, b) => a.team - b.team);

    utilities.postFrameCallback(notifyListeners);
  }

  void resetMatchDetails() {
    matchDetails = null;

    utilities.postFrameCallback(notifyListeners);
  }
}

/// Provider to handle matches
final matches = ChangeNotifierProvider((_) => _MatchesNotifier());
