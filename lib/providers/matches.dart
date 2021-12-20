import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;

class _MatchesNotifier extends ChangeNotifier {
  api.PlayerMatchesResponse? playerMatches;
  api.MatchDetailsResponse? matchDetails;

  Future<void> getPlayerMatches(String playerId) async {
    final response = await api.MatchRequests.playerMatches(playerId: playerId);
    if (response == null) return;
    playerMatches = response;

    notifyListeners();
  }
}

/// Provider to handle matches
final matches = ChangeNotifierProvider((_) => _MatchesNotifier());
