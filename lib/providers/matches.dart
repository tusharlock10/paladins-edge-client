import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/api/index.dart" as api;
import "package:paladinsedge/utilities/index.dart" as utilities;

class _MatchesNotifier extends ChangeNotifier {
  final String matchId;
  final ChangeNotifierProviderRef<_MatchesNotifier> ref;

  /// Match detail
  bool isMatchDetailsLoading = false;
  api.MatchDetailsResponse? matchDetails;

  _MatchesNotifier({
    required this.matchId,
    required this.ref,
  });

  Future<void> getMatchDetails() async {
    isMatchDetailsLoading = true;
    utilities.postFrameCallback(notifyListeners);

    final response = await api.MatchRequests.matchDetails(matchId: matchId);

    isMatchDetailsLoading = false;
    matchDetails = response;

    // sort players based on their team
    matchDetails?.matchPlayers.sort((a, b) => a.team.compareTo(b.team));

    notifyListeners();
  }

  void resetMatchDetails() {
    matchDetails = null;

    utilities.postFrameCallback(notifyListeners);
  }

  /// Clears all user sensitive data upon logout
  void clearData() {
    isMatchDetailsLoading = false;
    matchDetails = null;
  }
}

/// Provider to handle matches
final matches = ChangeNotifierProvider.family<_MatchesNotifier, String>(
  (ref, matchId) => _MatchesNotifier(ref: ref, matchId: matchId),
);
