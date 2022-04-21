import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class _MatchesNotifier extends ChangeNotifier {
  bool isPlayerMatchesLoading = false;
  bool isMatchDetailsLoading = false;
  api.PlayerMatchesResponse? playerMatches;
  api.MatchDetailsResponse? matchDetails;

  Future<void> getPlayerMatches({
    required String playerId,
    bool forceUpdate = false,
  }) async {
    if (!forceUpdate) {
      isPlayerMatchesLoading = true;
      utilities.postFrameCallback(notifyListeners);
    }

    final response = await api.MatchRequests.playerMatches(
      playerId: playerId,
      forceUpdate: forceUpdate,
    );

    // sort matches & matchPlayers based on matchId
    if (response != null) {
      response.matches.sort(
        (a, b) => int.parse(b.matchId).compareTo(int.parse(a.matchId)),
      );
      response.matchPlayers.sort(
        (a, b) => int.parse(b.matchId).compareTo(int.parse(a.matchId)),
      );
      playerMatches = response;
    }

    if (!forceUpdate) isPlayerMatchesLoading = false;

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
    matchDetails?.matchPlayers.sort((a, b) => a.team.compareTo(b.team));

    utilities.postFrameCallback(notifyListeners);
  }

  void resetMatchDetails() {
    matchDetails = null;

    utilities.postFrameCallback(notifyListeners);
  }

  /// Clears all user sensitive data upon logout
  void clearData() {
    isPlayerMatchesLoading = false;
    isMatchDetailsLoading = false;
    playerMatches = null;
    matchDetails = null;
  }
}

/// Provider to handle matches
final matches = ChangeNotifierProvider((_) => _MatchesNotifier());
