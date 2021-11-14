import 'package:flutter/foundation.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;

// Provider to handle players api response

class Players with ChangeNotifier {
  List<models.Player> friends = [];
  api.PlayerStatusResponse? playerStatus;
  models.Player? playerData;
  List<models.Player> topSearchList = [];
  List<api.LowerSearch> lowerSearchList = [];
  List<Map<String, dynamic>> searchHistory = []; // [{playerName, time]}]

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
    searchHistory = utilities.Database.getSearchHistory();
  }

  Future<bool> searchByName(
    String playerName, {
    bool simpleResults = false,
    required bool addInSeachHistory,
  }) async {
    // makes a req. to api for search
    // saves the searchItem in the searchHistory
    // saves the searchItem in the local db

    final response = await api.PlayersRequests.searchPlayers(
        playerName: playerName, simpleResults: false);
    if (response == null) {
      return true;
    } // return with simple results as true default value

    if (response.exactMatch) {
      playerData = response.playerData;
    } else {
      topSearchList = response.searchData.topSearchList;
      lowerSearchList = response.searchData.lowerSearchList;
    }
    final searchItem = {'playerName': playerName, 'time': DateTime.now()};
    if (addInSeachHistory) {
      searchHistory.insert(0, searchItem);
      utilities.Database.addSearchItem(searchItem);
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
