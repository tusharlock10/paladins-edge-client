import 'package:flutter/foundation.dart';

import '../Utilities/index.dart' as Utilities;
import '../Models/index.dart' as Models;
import '../Constants.dart' as Constants;

class Search with ChangeNotifier {
  Models.Player? playerData;
  List<Models.Player> topSearchList = [];
  List<dynamic> lowerSearchList = [];
  List<Map<String, dynamic>> searchHistory = []; // [{playerName, time]}]

  Future<bool> searchByName(String playerName) async {
    final response = await Utilities.api.get(
      Constants.Urls.searchPlayers,
      queryParameters: {'playerName': playerName},
    );
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
    this.searchHistory.add({'playerName': playerName, 'time': DateTime.now()});
    notifyListeners();
    return exactMatch;
  }

  void clearSearchList() {
    this.topSearchList = [];
    this.lowerSearchList = [];
    notifyListeners();
  }
}
