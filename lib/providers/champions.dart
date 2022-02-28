import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class _ChampionsNotifier extends ChangeNotifier {
  List<models.Champion> champions = [];
  List<models.PlayerChampion> userPlayerChampions =
      []; // holds playerChampions data for the user
  List<models.PlayerChampion>?
      playerChampions; // holds playerChampions data for other players

  /// Loads the `champions` data from local db and syncs it with server
  Future<void> loadChampions() async {
    // try to load champions from db
    final savedChampions = utilities.Database.getChampions();

    if (savedChampions != null) {
      champions = savedChampions;

      return;
    }

    final response = await api.ChampionsRequests.allChampions();
    if (response == null) return;
    champions = response.champions;

    // sort champions based on their name
    champions.sortedBy((champion) => champion.name);

    // save champion locally for future use
    champions.forEach(utilities.Database.saveChampion);
  }

  /// Loads the `playerChampions` data for the user from local db and
  /// syncs it with server for showing in Champions screen
  Future<void> loadUserPlayerChampions() async {
    final user = utilities.Database.getUser();
    final savedPlayerChampions = utilities.Database.getPlayerChampions();

    if (savedPlayerChampions != null) {
      userPlayerChampions = savedPlayerChampions;

      return;
    }

    if (user?.playerId == null) return;

    final response =
        await api.ChampionsRequests.playerChampions(playerId: user!.playerId!);

    if (response == null) return;
    userPlayerChampions = response.playerChampions;

    // save playerChampions locally for future use
    response.playerChampions.forEach(utilities.Database.savePlayerChampion);
  }

  /// Get the `playerChampions` data for the playerId
  Future<void> getPlayerChampions(String playerId) async {
    final response =
        await api.ChampionsRequests.playerChampions(playerId: playerId);
    if (response == null) return;
    playerChampions = response.playerChampions;
    utilities.postFrameCallback(notifyListeners);
  }

  /// Get the batch `playerChampions` data for the playerId and championId
  /// to be used in active match
  Future<void> getPlayerChampionsBatch(
    List<data_classes.BatchPlayerChampionsPayload> playerChampionsQuery,
  ) async {
    final response = await api.ChampionsRequests.batchPlayerChampions(
      playerChampionsQuery: playerChampionsQuery,
    );
    if (response == null) return;
    playerChampions = response.playerChampions;
    utilities.postFrameCallback(notifyListeners);
  }

  /// Deletes the plyerChampions
  void resetPlayerChampions() {
    playerChampions = null;
  }
}

/// Provider to handle champions
final champions = ChangeNotifierProvider((_) => _ChampionsNotifier());
