import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class _MatchesNotifier extends ChangeNotifier {
  api.PlayerMatchesResponse? playerMatches;
  api.MatchDetailsResponse? matchDetails;

  Future<void> getPlayerMatches(String playerId) async {
    final response = await api.MatchRequests.playerMatches(playerId: playerId);
    if (response == null) return;
    playerMatches = response;

    utilities.postFrameCallback(notifyListeners);
  }

  void resetPlayerMatches() {
    playerMatches = null;

    utilities.postFrameCallback(notifyListeners);
  }

  Future<void> getMatchDetails(String matchId) async {
    final response = await api.MatchRequests.matchDetails(matchId: matchId);
    if (response == null) return;
    matchDetails = response;

    utilities.postFrameCallback(notifyListeners);
  }

  void resetMatchDetails() {
    print('RESETTING');
    matchDetails = null;

    utilities.postFrameCallback(notifyListeners);
  }
}

/// Provider to handle matches
final matches = ChangeNotifierProvider((_) => _MatchesNotifier());
