import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import '../Utilities/index.dart' as Utilities;
import '../Models/index.dart' as Models;
import '../Constants.dart' as Constants;

class Search with ChangeNotifier {
  Models.Player? playerData;
  List<Models.Player> topSearchList = [];
  List<dynamic> lowerSearchList = [];
  List<Map<String, dynamic>> searchHistory = []; // [{playerName, time]}]

  getSearchHistory() {
    // gets the search history from local db
    this.searchHistory = Utilities.Database.getSearchHistory();
  }

  Future<bool> searchByName(String playerName,
      {bool simpleResults = false}) async {
    // makes a req. to api for search
    // saves the searchItem in the searchHistory
    // saves the searchItem in the local db
    Response response;
    try {
      response = await Utilities.api.get(
        Constants.Urls.searchPlayers,
        queryParameters: {
          'playerName': playerName,
          'simpleResults': simpleResults
        },
      );
    } catch (_) {
      return false;
    }
    final exactMatch = response.data['exactMatch'];
    if (exactMatch) {
      this.playerData = Models.Player.fromJson(response.data['playerData']);
    } else {
      this.topSearchList =
          (response.data['searchData']['topSearchList'] as List)
              .map((jsonMap) => Models.Player.fromJson(jsonMap))
              .toList();
      if (response.data['searchData']['lowerSearchList'] != null) {
        this.lowerSearchList =
            (response.data['searchData']['lowerSearchList'] as List)
                .map((searchItem) {
          return searchItem as Map<String, dynamic>;
        }).toList();
      }
    }
    final searchItem = {'playerName': playerName, 'time': DateTime.now()};
    this.searchHistory.insert(0, searchItem);
    Utilities.Database.addSearchItem(searchItem);
    notifyListeners();
    return exactMatch;
  }

  void clearSearchList() {
    this.topSearchList = [];
    this.lowerSearchList = [];
    notifyListeners();
  }

  void clearPlayerData() {
    this.playerData = null;
  }

  void getPlayerData(int playerId) async {
    Response response;
    try {
      response = await Utilities.api.get(
        Constants.Urls.playerDetail,
        queryParameters: {'playerId': playerId},
      );
    } catch (_) {
      return;
    }

    this.playerData = Models.Player.fromJson(response.data);
    notifyListeners();
  }
}
