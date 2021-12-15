import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class _PlayersNotifier extends ChangeNotifier {
  api.PlayerStatusResponse? playerStatus;
  models.Player? playerData;
  List<api.LowerSearch> lowerSearchList = [];
  List<models.Player> friends = [];
  List<models.Player> topSearchList = [];
  List<models.SearchHistory> searchHistory = [];

  void moveFriendToTop(String playerId) {
    // the player to move to top of the friends list
    final player = friends.firstWhere((friend) => friend.playerId == playerId);
    friends.removeWhere((friend) => friend.playerId == playerId);
    friends.insert(0, player);
    notifyListeners();
  }

  Future<void> getFriendsList(
      String playerId, List<String>? favouriteFriends) async {
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

    notifyListeners();
  }

  Future<void> getPlayerStatus(String playerId) async {
    playerStatus = null;
    final response = await api.PlayersRequests.playerStatus(playerId: playerId);
    playerStatus = response;
    notifyListeners();
  }

  getSearchHistory() {
    // gets the search history from local db
    final _searchHistory = utilities.Database.getSearchHistory();
    if (_searchHistory == null) {
      // it could be either because searchHistory has expired
      // or because there is no searchHistory
      searchHistory = [];
    } else {
      searchHistory = _searchHistory;
    }
  }

  Future<bool> searchByName({
    required String playerName,
    required bool simpleResults,
    required bool addInSeachHistory,
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
      playerData = response.playerData;
    } else {
      topSearchList = response.searchData.topSearchList;
      lowerSearchList = response.searchData.lowerSearchList;
    }
    final searchItem = models.SearchHistory(playerName: playerName);
    if (addInSeachHistory) {
      searchHistory.insert(0, searchItem);
      utilities.Database.saveSearchHistory(searchItem);
    }

    notifyListeners();
    return response.exactMatch;
  }

  void clearSearchList() {
    topSearchList = [];
    lowerSearchList = [];
    notifyListeners();
  }

  void clearPlayerData() {
    playerData = null;
  }

  void getPlayerData(String playerId) async {
    final response = await api.PlayersRequests.playerDetail(playerId: playerId);
    if (response == null) return;
    playerData = response.player;
    notifyListeners();
  }
}

/// Provider to handle players
final players = ChangeNotifierProvider((_) => _PlayersNotifier());
