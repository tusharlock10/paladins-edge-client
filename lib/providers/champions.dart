import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class _ChampionsNotifier extends ChangeNotifier {
  /// loading state for combinedChampions
  var isLoadingCombinedChampions = false;

  /// loading state for playerChampions
  var isLoadingPlayerChampions = false;

  /// holds data for all champions
  List<models.Champion> champions = [];

  /// holds playerChampions data for the user
  List<models.PlayerChampion>? userPlayerChampions;

  /// holds the champion and userPlayerChampion in one object for easy access
  List<data_classes.CombinedChampion>? combinedChampions;

  /// holds playerChampions data for other players
  List<models.PlayerChampion>? playerChampions;

  /// holds the value of currently active filter
  var selectedFilter = data_classes.SelectedChampionsFilter();

  /// holds the currently active filter
  String selectedSort = data_classes.ChampionsSort.defaultSort;

  /// Runs the `_loadChampions` and `_loadUserPlayerChampions` functions
  /// combines the result of them into one single entity of CombinedChampion
  Future<void> loadCombinedChampions(bool forceUpdate) async {
    // don't show loading indicator when refreshing
    if (!forceUpdate) isLoadingCombinedChampions = true;

    final result = await Future.wait([
      // champions do not have forceUpdate
      // return previous value if forceUpdate
      forceUpdate ? Future.value(champions) : _loadChampions(),
      _loadUserPlayerChampions(forceUpdate),
    ]);

    // if champions is null, then abort this operation
    if (result.first == null) {
      if (!forceUpdate) {
        isLoadingCombinedChampions = false;
        notifyListeners();
      }

      return;
    }

    if (!forceUpdate) isLoadingCombinedChampions = false;
    champions = result.first as List<models.Champion>;

    // userPlayerChampions might be null on isGuest or forceUpdate
    if (result.last != null) {
      userPlayerChampions = result.last as List<models.PlayerChampion>;
    }

    combinedChampions = champions.map((champion) {
      final playerChampion = utilities.findPlayerChampion(
        userPlayerChampions,
        champion.championId,
      );

      return data_classes.CombinedChampion(
        champion: champion,
        playerChampion: playerChampion,
      );
    }).toList();

    // sort champions based on the selectedSort
    combinedChampions = data_classes.ChampionsSort.getSortedChampions(
      combinedChampions: combinedChampions!,
      sort: selectedSort,
    );

    notifyListeners();
  }

  /// Get the `playerChampions` data for the playerId
  Future<void> getPlayerChampions(String playerId) async {
    isLoadingPlayerChampions = true;

    final response =
        await api.ChampionsRequests.playerChampions(playerId: playerId);

    isLoadingPlayerChampions = false;
    if (response != null) playerChampions = response.playerChampions;

    notifyListeners();
  }

  /// Get the batch `playerChampions` data for the playerId and championId
  /// to be used in active match
  Future<void> getPlayerChampionsBatch(
    List<data_classes.BatchPlayerChampionsPayload> playerChampionsQuery,
  ) async {
    isLoadingPlayerChampions = true;
    final response = await api.ChampionsRequests.batchPlayerChampions(
      playerChampionsQuery: playerChampionsQuery,
    );

    isLoadingPlayerChampions = false;
    if (response != null) playerChampions = response.playerChampions;

    notifyListeners();
  }

  /// Deletes the plyerChampions
  void resetPlayerChampions() {
    playerChampions = null;
  }

  /// Filters the champions based on the search provided
  void filterChampionsBySearch(String search) {
    if (combinedChampions == null) return;

    // remove filters if search is done
    // but keep the previous filterName intact
    selectedFilter = data_classes.SelectedChampionsFilter(
      name: selectedFilter.name,
    );

    combinedChampions = data_classes.ChampionsFilter.filterBySearch(
      combinedChampions!,
      search,
    );

    notifyListeners();
  }

  /// Set the name of filter
  void setFilterName(String filterName) {
    selectedFilter = data_classes.SelectedChampionsFilter(name: filterName);

    notifyListeners();
  }

  /// Set value of filter and apply the filter
  void setFilterValue(String filterValue) {
    selectedFilter = data_classes.SelectedChampionsFilter(
      name: selectedFilter.name,
      value: filterValue,
    );

    if (selectedFilter.isValid && combinedChampions != null) {
      combinedChampions = data_classes.ChampionsFilter.getFilteredChampions(
        combinedChampions: combinedChampions!,
        filter: selectedFilter,
      );
    }

    notifyListeners();
  }

  /// Set value of sort and apply sorting
  void setSort(String sort) {
    if (combinedChampions == null) return;

    selectedSort = sort;
    combinedChampions = data_classes.ChampionsSort.getSortedChampions(
      combinedChampions: combinedChampions!,
      sort: sort,
    );

    notifyListeners();
  }

  /// Clears all applied filters and sort on combinedChampions
  void clearAppliedFiltersAndSort() {
    if (combinedChampions == null) return;

    combinedChampions = data_classes.ChampionsFilter.clearFilters(
      combinedChampions!,
    );
    combinedChampions = data_classes.ChampionsSort.clearSorting(
      combinedChampions!,
    );
    selectedFilter = data_classes.SelectedChampionsFilter(
      name: selectedFilter.name,
    );
    selectedSort = data_classes.ChampionsSort.defaultSort;

    notifyListeners();
  }

  /// Clears all user sensitive data upon logout
  void clearData() {
    isLoadingCombinedChampions = false;
    isLoadingPlayerChampions = false;
    champions = [];
    userPlayerChampions = null;
    combinedChampions = null;
    playerChampions = null;
    selectedFilter = data_classes.SelectedChampionsFilter();
    selectedSort = data_classes.ChampionsSort.defaultSort;
  }

  /// Loads the `champions` data from local db and syncs it with server
  Future<List<models.Champion>?> _loadChampions() async {
    // try to load champions from db

    final savedChampions = utilities.Database.getChampions();
    if (savedChampions != null) return savedChampions;

    final response = await api.ChampionsRequests.allChampions();
    if (response == null) return null;

    final _champions = response.champions;

    // save champion locally for future use
    _champions.forEach(utilities.Database.saveChampion);

    // sort champions based on their name
    return _champions.sortedBy((champion) => champion.name);
  }

  /// Loads the `playerChampions` data for the user from local db and
  /// syncs it with server for showing in Champions screen
  Future<List<models.PlayerChampion>?> _loadUserPlayerChampions(
    bool forceUpdate,
  ) async {
    final user = utilities.Database.getUser();
    final playerId = user?.playerId;
    if (playerId == null) return null;

    // on forceUpdate, skip getting data from local db
    if (!forceUpdate) {
      final savedPlayerChampions = utilities.Database.getPlayerChampions();
      if (savedPlayerChampions != null) return savedPlayerChampions;
    }

    // response will be null if we try to forceUpdate earlier than intended
    final response = await api.ChampionsRequests.playerChampions(
      playerId: playerId,
      forceUpdate: forceUpdate,
    );

    if (response == null) return null;

    // clear the playerChampions in db if forceUpdate
    // save playerChampions locally for future use
    if (forceUpdate) await utilities.Database.playerChampionBox?.clear();
    response.playerChampions.forEach(utilities.Database.savePlayerChampion);

    return response.playerChampions;
  }
}

/// Provider to handle champions
final champions = ChangeNotifierProvider((_) => _ChampionsNotifier());
