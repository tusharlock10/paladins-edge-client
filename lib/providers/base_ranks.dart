import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/api/index.dart" as api;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;

class _BaseRanksNotifier extends ChangeNotifier {
  bool isLoading = true;
  Map<int, models.BaseRank> baseRanks = {};

  /// Loads the `baseRank` data from local db and syncs it with server
  Future<void> loadBaseRanks() async {
    var ranksList = utilities.Database.getBaseRanks();

    if (ranksList == null) {
      final response = await api.BaseRankRequests.baseRanks();
      if (response == null) return;
      ranksList = response.ranks;

      // save baseRanks locally for future use
      ranksList.forEach(utilities.Database.saveBaseRank);
    }

    for (var baseRank in ranksList) {
      baseRanks[baseRank.rank] = baseRank;
    }
  }
}

/// Provider to handle baseRanks
final baseRanks = ChangeNotifierProvider((_) => _BaseRanksNotifier());
