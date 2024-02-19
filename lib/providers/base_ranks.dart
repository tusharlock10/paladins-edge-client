import "package:dartx/dartx.dart";
import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/api/index.dart" as api;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;

class _BaseRanksNotifier extends ChangeNotifier {
  bool isLoading = true;
  List<models.BaseRank> validRanks = [];
  Map<int, models.BaseRank> baseRanks = {};

  static List<models.BaseRank> getValidRanks(
    Map<int, models.BaseRank> baseRanks,
  ) {
    final invalidRanks = [0, 27];
    final List<models.BaseRank> validRanks = [];
    final ranks = baseRanks.keys.sorted().reversed;

    for (var rank in ranks) {
      if (invalidRanks.contains(rank)) continue;
      validRanks.add(baseRanks[rank]!);
    }

    return validRanks;
  }

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
    validRanks = getValidRanks(baseRanks);
  }
}

/// Provider to handle baseRanks
final baseRanks = ChangeNotifierProvider((_) => _BaseRanksNotifier());
