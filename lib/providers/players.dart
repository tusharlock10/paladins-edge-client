import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/api/index.dart" as api;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;

class _PlayersNotifier extends ChangeNotifier {
  bool isLoadingPlayerData = false;
  bool isLoadingPlayerStatus = false;
  models.Player? playerData;
  api.PlayerStatusResponse? playerStatus;
  List<api.LowerSearch> lowerSearchList = [];
  List<models.Player> topSearchList = [];
  List<models.SearchHistory> searchHistory = [];
  final ChangeNotifierProviderRef<_PlayersNotifier> ref;

  _PlayersNotifier({required this.ref});

  Future<void> getPlayerStatus({
    required String playerId,
    bool forceUpdate = false,
    bool onlyStatus = false,
  }) async {
    if (!forceUpdate) {
      isLoadingPlayerStatus = true;
      utilities.postFrameCallback(notifyListeners);
    }

    playerStatus = await api.PlayersRequests.playerStatus(
      playerId: playerId,
      onlyStatus: onlyStatus,
    );

    playerStatus ??= api.PlayerStatusResponse(
      inMatch: false,
      playerId: "0",
      status: "Unknown",
      match: null,
    );

    if (!forceUpdate) isLoadingPlayerStatus = false;
    notifyListeners();
  }

  /// Loads the `searchHistory` data for the user from local db and
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
  }) async {
    // makes a req. to api for search
    // saves the searchItem in the searchHistory
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
      playerData = response.playerData;

      if (addInSearchHistory && playerData != null) {
        await insertSearchHistory(
          playerName: playerData!.name,
          playerId: playerData!.playerId,
        );
      }
    } else {
      topSearchList = response.searchData.topSearchList;
      lowerSearchList = response.searchData.lowerSearchList;
    }

    notifyListeners();

    return response;
  }

  void clearSearchList() {
    topSearchList = [];
    lowerSearchList = [];
    notifyListeners();
  }

  Future<void> getPlayerData({
    required String playerId,
    required bool forceUpdate,
  }) async {
    if (!forceUpdate) {
      isLoadingPlayerData = true;
      utilities.postFrameCallback(notifyListeners);
    }

    final response = await api.PlayersRequests.playerDetail(
      playerId: playerId,
      forceUpdate: forceUpdate,
    );

    if (response == null) {
      if (!forceUpdate) isLoadingPlayerData = false;
      notifyListeners();

      return;
    }

    playerData = response.player;

    await insertSearchHistory(
      playerName: playerData!.name,
      playerId: playerId,
    );

    if (!forceUpdate) isLoadingPlayerData = false;
    notifyListeners();
  }

  void resetPlayerStatus() {
    playerStatus = null;
    isLoadingPlayerStatus = false;

    utilities.postFrameCallback(notifyListeners);
  }

  /// Clears all user sensitive data upon logout
  void clearData() {
    isLoadingPlayerData = false;
    isLoadingPlayerStatus = false;
    playerData = null;
    playerStatus = null;
    lowerSearchList = [];
    topSearchList = [];
    searchHistory = [];
  }
}

/// Provider to handle players
final players = ChangeNotifierProvider((ref) => _PlayersNotifier(ref: ref));
