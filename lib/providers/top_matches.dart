import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/api/index.dart" as api;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;

class _TopMatchesNotifier extends ChangeNotifier {
  bool isLoading = true;
  List<models.TopMatch>? topMatches;

  /// Loads the `topMatches` data from local db and syncs it with server
  Future<void> loadTopMatches(bool forceUpdate) async {
    final savedTopMatches =
        forceUpdate ? null : utilities.Database.getTopMatches();

    if (savedTopMatches != null) {
      isLoading = false;
      topMatches = savedTopMatches;

      return utilities.postFrameCallback(notifyListeners);
    }

    final response = await api.MatchRequests.topMatches();
    if (response == null) return;

    isLoading = false;
    topMatches = response.topMatches;
    notifyListeners();

    // save topMatches locally for future use
    // clear topMatches first if forceUpdate
    if (forceUpdate) await utilities.Database.topMatchBox?.clear();
    topMatches?.forEach(utilities.Database.saveTopMatch);
  }
}

/// Provider to handle baseRanks
final topMatches = ChangeNotifierProvider((_) => _TopMatchesNotifier());
