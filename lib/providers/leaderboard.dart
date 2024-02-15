import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/api/index.dart" as api;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;

class _LeaderboardNotifier extends ChangeNotifier {
  bool isLoading = true;
  int rank = 26;
  List<models.LeaderboardPlayer>? leaderboardPlayers;

  Future<void> getLeaderboardPlayers() async {
    final response = await api.LeaderboardRequests.leaderboardPlayers(rank);
    if (response == null) return;

    response.leaderboardPlayers
        .sort((a, b) => a.position.compareTo(b.position));
    leaderboardPlayers = response.leaderboardPlayers;

    return utilities.postFrameCallback(notifyListeners);
  }
}

/// Provider to handle leaderboard
final leaderboard = ChangeNotifierProvider((_) => _LeaderboardNotifier());
