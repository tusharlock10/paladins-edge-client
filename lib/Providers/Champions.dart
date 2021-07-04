import 'package:flutter/foundation.dart';

import '../Utilities/index.dart' as Utilities;
import '../Models/index.dart' as Models;
import '../Constants.dart' as Constants;

class Champions with ChangeNotifier {
  List<Models.Champion> champions = [];
  List<Models.PlayerChampion> playerChampions = [];

  Future<void> fetchChampions() async {
    final response = await Utilities.api
        .get(Constants.Urls.allChampions, queryParameters: {'allData': true});
    final data = response.data as List<dynamic>;
    this.champions =
        data.map((jsonMap) => Models.Champion.fromJson(jsonMap)).toList();
    notifyListeners();
  }

  Future<void> fetchPlayerChampions(String playerId) async {
    final response = await Utilities.api.get(Constants.Urls.playerChampionsData,
        queryParameters: {'playerId': playerId});
    final data = response.data as List<dynamic>;
    this.playerChampions =
        data.map((jsonMap) => Models.PlayerChampion.fromJson(jsonMap)).toList();
    notifyListeners();
  }
}
