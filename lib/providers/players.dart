import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class _PlayersNotifier extends ChangeNotifier {
  bool isLoadingPlayerData = false;
  String? playerId;
  String? playerStatusPlayerId;
  models.Player? playerData;
  api.PlayerStatusResponse? playerStatus;
  List<api.LowerSearch> lowerSearchList = [];
  List<models.Player> friends = [];
  List<models.Player> topSearchList = [];
  List<models.SearchHistory> searchHistory = [];

  void moveFriendToTop(String playerId) {
    // the player to move to top of the friends list
    final player =
        friends.firstOrNullWhere((friend) => friend.playerId == playerId);

    if (player == null) return;

    friends.removeWhere((friend) => friend.playerId == playerId);
    friends.insert(0, player);

    utilities.postFrameCallback(notifyListeners);
  }

  Future<void> getFriendsList(
    String playerId,
    List<String>? favouriteFriends,
  ) async {
    final response = await api.PlayersRequests.friendsList(playerId: playerId);
    if (response == null) return;
    friends = response.friends;

    if (favouriteFriends != null) {
      // sort the friends on the basis on name
      friends.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );

      // find favourite players
      final List<models.Player> favouritePlayers = [];
      friends.removeWhere((friend) {
        if (favouriteFriends.contains(friend.playerId)) {
          favouritePlayers.add(friend);

          return true;
        }

        return false;
      });

      friends = favouritePlayers + friends;
    }

    utilities.postFrameCallback(notifyListeners);
  }

  Future<void> getPlayerStatus(String playerId) async {
    playerStatus = await api.PlayersRequests.playerStatus(playerId: playerId);

    utilities.postFrameCallback(notifyListeners);
  }

  /// Loads the `searchHistory` data for the user from local db and
  /// syncs it with server for showing in Search screen
  void loadSearchHistory() async {
    // gets the search history from local db
    final _searchHistory = utilities.Database.getSearchHistory();

    // if searchHistory is not available
    // fetch it from backend
    if (_searchHistory == null) {
      final response = await api.PlayersRequests.searchHistory();

      if (response == null) {
        searchHistory = [];

        return;
      }

      searchHistory = response.searchHistory;
      response.searchHistory.forEach(utilities.Database.saveSearchHistory);
    } else {
      searchHistory = _searchHistory;
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

  Future<bool> searchByName({
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
      return false;
    }

    if (response.exactMatch) {
      playerId = response.playerData!.playerId;
      playerData = response.playerData;

      if (addInSearchHistory) {
        await insertSearchHistory(
          playerName: playerData!.name,
          playerId: playerId!,
        );
      }
    } else {
      topSearchList = response.searchData.topSearchList;
      lowerSearchList = response.searchData.lowerSearchList;
    }

    utilities.postFrameCallback(notifyListeners);

    return response.exactMatch;
  }

  void clearSearchList() {
    topSearchList = [];
    lowerSearchList = [];
    utilities.postFrameCallback(notifyListeners);
  }

  /// The the playerId of the player to be shown in profile detail screen
  void setPlayerId(String _playerId) {
    playerData = null;
    playerId = _playerId;

    utilities.postFrameCallback(notifyListeners);
  }

  /// The the playerId of the player to be shown in active match screen
  void setPlayerStatusPlayerId(String _playerStatusPlayerId) {
    playerStatus = null;
    playerStatusPlayerId = _playerStatusPlayerId;

    utilities.postFrameCallback(notifyListeners);
  }

  void getPlayerData({
    required bool forceUpdate,
  }) async {
    if (playerId == null) return;

    isLoadingPlayerData = true;
    utilities.postFrameCallback(notifyListeners);

    final response = await api.PlayersRequests.playerDetail(
      playerId: playerId!,
      forceUpdate: forceUpdate,
    );

    if (response == null) {
      isLoadingPlayerData = false;
      utilities.postFrameCallback(notifyListeners);

      return null;
    }

    playerData = response.player;

    await insertSearchHistory(
      playerName: playerData!.name,
      playerId: playerId!,
    );

    isLoadingPlayerData = false;
    utilities.postFrameCallback(notifyListeners);
  }

  /// Clears all user sensitive data upon logout
  void clearData() {
    isLoadingPlayerData = false;
    playerId = null;
    playerStatusPlayerId = null;
    playerData = null;
    playerStatus = null;
    lowerSearchList = [];
    friends = [];
    topSearchList = [];
    searchHistory = [];
  }
}

/// Provider to handle players
final players = ChangeNotifierProvider((_) => _PlayersNotifier());
