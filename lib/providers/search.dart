import 'package:flutter/foundation.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;

// TODO: Remove this provider and move it to Players
// search is a part of Players api not a seperate entity

class Search with ChangeNotifier {
  models.Player? playerData;
  List<models.Player> topSearchList = [];
  List<api.LowerSearch> lowerSearchList = [];
  List<Map<String, dynamic>> searchHistory = []; // [{playerName, time]}]

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
