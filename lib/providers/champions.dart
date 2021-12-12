import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class _ChampionsState {
  List<models.Champion> champions = [];
  List<models.PlayerChampion> playerChampions = [];

  /// Loads the `champions` data from local db and syncs it with server
  Future<void> loadChampions() async {
    // try to load chhampions from db
    final savedChampions = utilities.Database.getChampions();

    if (savedChampions != null) {
      champions = savedChampions;
      return;
    }

    final response = await api.ChampionsRequests.allChampions(allData: true);
    if (response == null) return;
    champions = response.champions;

    // sort champions based on their name
    champions
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    // save champion locally for future use
    champions.forEach(utilities.Database.saveChampion);
  }

  /// Loads the `champions` data from local db and syncs it with server
  Future<void> loadPlayerChampions(String playerId) async {
    final response =
        await api.ChampionsRequests.playerChampions(playerId: playerId);
    if (response == null) return;
    playerChampions = response.playerChampions;
  }
}

/// Provider to handle champions
final champions = Provider((_) => _ChampionsState());
