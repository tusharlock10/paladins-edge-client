import 'package:flutter/foundation.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;

class Champions with ChangeNotifier {
  List<models.Champion> champions = [];
  List<models.PlayerChampion> playerChampions = [];

  Future<void> fetchChampions() async {
    final response = await api.ChampionsRequests.allChampions(allData: true);
    if (response == null) return;
    champions = response.champions;
    champions
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    notifyListeners();
  }

  Future<void> fetchPlayerChampions(String playerId) async {
    final response =
        await api.ChampionsRequests.playerChampions(playerId: playerId);
    if (response == null) return;
    playerChampions = response.playerChampions;
    notifyListeners();
  }
}
