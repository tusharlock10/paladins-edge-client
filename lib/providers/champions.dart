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
    champions
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

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
    notifyListeners();
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
    notifyListeners();
  }

  /// Deletes the plyerChampions
  void resetPlayerChampions() {
    playerChampions = null;
  }

  /// Sort playerChampions on basis of name
  void sortPlayerChampionsName(bool ascending) {
    if (playerChampions == null) return;

    final _playerChampions = [...playerChampions!];

    _playerChampions.sort((a, b) {
      // get the name of the champion from champions list
      final aName =
          champions.firstOrNullWhere((_) => _.championId == a.championId)?.name;
      final bName =
          champions.firstOrNullWhere((_) => _.championId == b.championId)?.name;

      if (aName == null || bName == null) return 0;

      if (ascending) return bName.compareTo(aName);

      return aName.compareTo(bName);
    });

    playerChampions = _playerChampions;

    notifyListeners();
  }

  /// Sort playerChampions on basis of matches
  void sortPlayerChampionsMatches(bool ascending) {
    if (playerChampions == null) return;

    final _playerChampions = [...playerChampions!];

    _playerChampions.sort((a, b) {
      final aMatches = a.wins + a.losses;
      final bMatches = b.wins + b.losses;
      if (ascending) return bMatches.compareTo(aMatches);

      return aMatches.compareTo(bMatches);
    });

    playerChampions = _playerChampions;

    notifyListeners();
  }

  /// Sort playerChampions on basis of kills
  void sortPlayerChampionsKills(bool ascending) {
    if (playerChampions == null) return;

    final _playerChampions = [...playerChampions!];

    _playerChampions.sort((a, b) {
      if (ascending) return b.totalKills.compareTo(a.totalKills);

      return a.totalKills.compareTo(b.totalKills);
    });

    playerChampions = _playerChampions;

    notifyListeners();
  }

  /// Sort playerChampions on basis of deaths
  void sortPlayerChampionsDeaths(bool ascending) {
    if (playerChampions == null) return;

    final _playerChampions = [...playerChampions!];

    _playerChampions.sort((a, b) {
      if (ascending) return b.totalDeaths.compareTo(a.totalDeaths);

      return a.totalDeaths.compareTo(b.totalDeaths);
    });

    playerChampions = _playerChampions;

    notifyListeners();
  }

  /// Sort playerChampions on basis of KDA
  void sortPlayerChampionsKDA(bool ascending) {
    if (playerChampions == null) return;

    final _playerChampions = [...playerChampions!];

    _playerChampions.sort((a, b) {
      final aKda = (a.totalKills + a.totalAssists) / a.totalDeaths;
      final bKda = (b.totalKills + b.totalAssists) / b.totalDeaths;
      if (ascending) return bKda.compareTo(aKda);

      return aKda.compareTo(bKda);
    });

    playerChampions = _playerChampions;

    notifyListeners();
  }

  /// Sort playerChampions on basis of win rate
  void sortPlayerChampionsWinRate(bool ascending) {
    if (playerChampions == null) return;

    final _playerChampions = [...playerChampions!];

    _playerChampions.sort((a, b) {
      final aWinRate = a.wins * 100 / (a.losses + a.wins);
      final bWinRate = b.wins * 100 / (b.losses + b.wins);
      if (ascending) return bWinRate.compareTo(aWinRate);

      return aWinRate.compareTo(bWinRate);
    });

    playerChampions = _playerChampions;

    notifyListeners();
  }

  /// Sort playerChampions on basis of play time
  void sortPlayerChampionsPlayTime(bool ascending) {
    if (playerChampions == null) return;

    final _playerChampions = [...playerChampions!];

    _playerChampions.sort((a, b) {
      if (ascending) return b.playTime.compareTo(a.playTime);

      return a.playTime.compareTo(a.playTime);
    });

    playerChampions = _playerChampions;

    notifyListeners();
  }

  /// Sort playerChampions on basis of level
  void sortPlayerChampionsLevel(bool ascending) {
    if (playerChampions == null) return;

    final _playerChampions = [...playerChampions!];

    _playerChampions.sort((a, b) {
      if (ascending) return b.level.compareTo(a.level);

      return a.level.compareTo(b.level);
    });

    playerChampions = _playerChampions;

    notifyListeners();
  }

  /// Sort playerChampions on basis of last played
  void sortPlayerChampionsLastPlayed(bool ascending) {
    if (playerChampions == null) return;

    final _playerChampions = [...playerChampions!];

    _playerChampions.sort((a, b) {
      if (ascending) return b.lastPlayed.compareTo(a.lastPlayed);

      return a.lastPlayed.compareTo(b.lastPlayed);
    });

    playerChampions = _playerChampions;

    notifyListeners();
  }
}

/// Provider to handle champions
final champions = ChangeNotifierProvider((_) => _ChampionsNotifier());
