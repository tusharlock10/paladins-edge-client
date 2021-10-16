import 'package:flutter/foundation.dart';

import '../Api/index.dart' as Api;
import '../Models/index.dart' as Models;

class Champions with ChangeNotifier {
  List<Models.Champion> champions = [];
  List<Models.PlayerChampion> playerChampions = [];

  Future<void> fetchChampions() async {
    final response = await Api.ChampionsRequests.allChampions(allData: true);
    this.champions = response.champions;
    notifyListeners();
  }

  Future<void> fetchPlayerChampions(String playerId) async {
    final response =
        await Api.ChampionsRequests.playerChampions(playerId: playerId);
    this.playerChampions = response.playerChampions;
    notifyListeners();
  }
}
