import 'package:flutter/foundation.dart';

import '../Api/index.dart' as Api;
import '../Models/index.dart' as Models;
import '../Utilities/index.dart' as Utilities;

// TODO: Remove this provider and move it to Players
// search is a part of Players api not a seperate entity

class Search with ChangeNotifier {
  Models.Player? playerData;
  List<Models.Player> topSearchList = [];
  List<Api.LowerSearch> lowerSearchList =
      []; // TODO: Refactor it such that Api.LowerSearch is should be used
  List<Map<String, dynamic>> searchHistory = []; // [{playerName, time]}]

  getSearchHistory() {
    // gets the search history from local db
    this.searchHistory = Utilities.Database.getSearchHistory();
  }

  Future<bool> searchByName(
    String playerName, {
    bool simpleResults = false,
    required bool addInSeachHistory,
  }) async {
    // makes a req. to api for search
    // saves the searchItem in the searchHistory
    // saves the searchItem in the local db

    final response = await Api.PlayersRequests.searchPlayers(
        playerName: playerName, simpleResults: false);

    if (response.exactMatch) {
      this.playerData = response.playerData;
    } else {
      this.topSearchList = response.searchData.topSearchList;
      this.lowerSearchList = response.searchData.lowerSearchList;
    }
    final searchItem = {'playerName': playerName, 'time': DateTime.now()};
    if (addInSeachHistory) {
      this.searchHistory.insert(0, searchItem);
      Utilities.Database.addSearchItem(searchItem);
    }
    notifyListeners();
    return response.exactMatch;
  }

  void clearSearchList() {
    this.topSearchList = [];
    this.lowerSearchList = [];
    notifyListeners();
  }

  void clearPlayerData() {
    this.playerData = null;
  }

  void getPlayerData(String playerId) async {
    final response = await Api.PlayersRequests.playerDetail(playerId: playerId);
    this.playerData = response.player;
    notifyListeners();
  }
}
