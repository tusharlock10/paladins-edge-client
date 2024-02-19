import "package:dartx/dartx.dart";
import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/api/index.dart" as api;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/utilities/index.dart" as utilities;

class _LeaderboardNotifier extends ChangeNotifier {
  final ChangeNotifierProviderRef<_LeaderboardNotifier> ref;
  bool isLoading = true;
  int? selectedRank;
  List<models.LeaderboardPlayer>? leaderboardPlayers;

  _LeaderboardNotifier({required this.ref});

  Future<void> getLeaderboardPlayers() async {
    if (selectedRank == null) return;

    isLoading = true;
    utilities.postFrameCallback(notifyListeners);

    final response = await api.LeaderboardRequests.leaderboardPlayers(
      selectedRank!,
    );
    if (response == null) return;

    response.leaderboardPlayers.sort(
      (a, b) => a.position.compareTo(b.position),
    );
    leaderboardPlayers = response.leaderboardPlayers;
    isLoading = false;

    return notifyListeners();
  }

  void loadSelectedRank() {
    if (selectedRank != null) return;

    final validRanks = ref.read(providers.baseRanks).validRanks;
    if (validRanks.isNotEmpty) {
      selectedRank = validRanks.maxBy((_) => _.rank)!.rank;
    }

    utilities.postFrameCallback(notifyListeners);
  }

  void setSelectedRank(int rank) {
    selectedRank = rank;
    notifyListeners();
  }
}

/// Provider to handle leaderboard
final leaderboard = ChangeNotifierProvider<_LeaderboardNotifier>(
  (ref) => _LeaderboardNotifier(ref: ref),
);
