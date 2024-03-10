import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/api/index.dart" as api;
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;

class _SearchNotifier extends ChangeNotifier {
  List<api.LowerSearch> lowerSearchList = [];
  List<models.Player> topSearchList = [];
  List<models.SearchHistory> searchHistory = [];

  // Loads the `searchHistory` data for the user from local db and
  /// syncs it with server for showing in Search screen
  void loadSearchHistory() async {
    // gets the search history from local db
    final savedSearchHistory = utilities.Database.getSearchHistory();

    // if searchHistory is not available
    // fetch it from backend
    if (savedSearchHistory == null) {
      final response = await api.PlayersRequests.searchHistory();

      if (response == null) {
        searchHistory = [];

        return;
      }

      searchHistory = response.searchHistory;
      response.searchHistory.forEach(utilities.Database.saveSearchHistory);
    } else {
      searchHistory = savedSearchHistory;
    }

    // remove searchHistory older than 7 days
    searchHistory = searchHistory
        .where(
          (searchItem) =>
              DateTime.now().difference(searchItem.time) <
              const Duration(days: 7),
        )
        .toList();

    // sort search history on basis of time
    searchHistory.sort((a, b) => b.time.compareTo(a.time));

    utilities.postFrameCallback(notifyListeners);
  }

  /// add the searched player in searchHistory
  Future<void> insertSearchHistory({
    required String playerName,
    required String playerId,
  }) async {
    // remove existing searchItem
    final index = searchHistory.indexWhere((_) => _.playerId == playerId);
    if (index != -1) searchHistory.removeAt(index);

    final searchItem = models.SearchHistory(
      playerName: playerName,
      playerId: playerId,
      time: DateTime.now(),
    );

    searchHistory.insert(0, searchItem);

    // remove all entries from searchBox and reinsert entries
    await utilities.Database.searchHistoryBox?.clear();
    searchHistory.forEach(utilities.Database.saveSearchHistory);
  }

  Future<api.SearchPlayersResponse?> searchByName({
    required String playerName,
    required bool simpleResults,
    required bool addInSearchHistory,
    required void Function(String) onNotFound,
  }) async {
    // makes a request to api for search
    // saves the searchItem in the local db

    final response = await api.PlayersRequests.searchPlayers(
      playerName: playerName,
      simpleResults: simpleResults,
    );

    if (response == null) {
      // return false when api call is not successful
      return null;
    }

    if (response.exactMatch) {
      final playerData = response.playerData;

      if (addInSearchHistory && playerData != null) {
        await insertSearchHistory(
          playerName: playerData.name,
          playerId: playerData.playerId,
        );
      }
    } else {
      topSearchList = response.searchData.topSearchList;
      lowerSearchList = response.searchData.lowerSearchList;

      if (topSearchList.isEmpty && lowerSearchList.isEmpty) {
        onNotFound(playerName);
      }
    }
    utilities.Analytics.logEvent(
      constants.AnalyticsEvent.searchPlayer,
      {"playerName": playerName},
    );

    notifyListeners();

    return response;
  }

  void clearSearchList() {
    topSearchList = [];
    lowerSearchList = [];
    notifyListeners();
  }

  /// Clears all user sensitive data upon logout
  void clearData() {
    lowerSearchList = [];
    topSearchList = [];
    searchHistory = [];
  }
}

/// Provider to handle baseRanks
final search = ChangeNotifierProvider((_) => _SearchNotifier());
