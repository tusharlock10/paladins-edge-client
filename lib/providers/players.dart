import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class _PlayersNotifier extends ChangeNotifier {
  bool isLoadingPlayerData = false;
  api.PlayerStatusResponse? playerStatus;
  String? playerId;
  models.Player? playerData;
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
      friends.sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });

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
    playerStatus = null;
    final response = await api.PlayersRequests.playerStatus(playerId: playerId);
    playerStatus = response;
    utilities.postFrameCallback(notifyListeners);
  }

  getSearchHistory() {
    // gets the search history from local db
    final _searchHistory = utilities.Database.getSearchHistory();
    searchHistory = _searchHistory ?? [];
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
      playerId = response.playerData?.playerId;
      playerData = response.playerData;
    } else {
      topSearchList = response.searchData.topSearchList;
      lowerSearchList = response.searchData.lowerSearchList;
    }
    final searchItem = models.SearchHistory(playerName: playerName);
    if (addInSearchHistory) {
      searchHistory.insert(0, searchItem);
      utilities.Database.saveSearchHistory(searchItem);
    }

    utilities.postFrameCallback(notifyListeners);

    return response.exactMatch;
  }

  void clearSearchList() {
    topSearchList = [];
    lowerSearchList = [];
    utilities.postFrameCallback(notifyListeners);
  }

  void setPlayerId(String _playerId) {
    playerData = null;
    playerId = _playerId;

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

    isLoadingPlayerData = false;
    utilities.postFrameCallback(notifyListeners);
  }
}

/// Provider to handle players
final players = ChangeNotifierProvider((_) => _PlayersNotifier());
