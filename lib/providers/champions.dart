import "package:dartx/dartx.dart";
import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/api/index.dart" as api;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/auth.dart" as auth_provider;
import "package:paladinsedge/utilities/index.dart" as utilities;

class _ChampionsNotifier extends ChangeNotifier {
  final ChangeNotifierProviderRef<_ChampionsNotifier> ref;

  /// loading state for combinedChampions
  bool isLoadingCombinedChampions = false;

  /// loading state for playerChampions
  bool isLoadingPlayerChampions = false;

  /// holds the search value for champions
  String search = "";

  /// holds data for all champions
  List<models.Champion> champions = [];

  /// holds playerChampions data for the user
  List<models.PlayerChampion>? userPlayerChampions;

  /// holds the champion and userPlayerChampion in one object for easy access
  List<data_classes.CombinedChampion>? combinedChampions;

  /// stores the playerId associated with the playerChampions
  String? playerChampionsPlayerId;

  /// holds playerChampions data for other players
  List<models.PlayerChampion>? playerChampions;

  /// holds the value of currently active filter
  data_classes.SelectedChampionsFilter selectedFilter =
      data_classes.SelectedChampionsFilter();

  /// holds the currently active filter
  String selectedSort = data_classes.ChampionsSort.defaultSort;

  // holds the list of favourite champions of the user
  Set<int> favouriteChampions = {};

  _ChampionsNotifier({required this.ref});

  /// Finds and returns the champion from its championId
  models.Champion? findChampion(int championId) {
    return champions.firstOrNullWhere((_) => _.championId == championId);
  }

  /// Runs the `_loadChampions` and `_loadUserPlayerChampions` functions
  /// combines the result of them into one single entity of CombinedChampion
  Future<void> loadCombinedChampions([bool forceUpdate = false]) async {
    // don't show loading indicator when refreshing
    if (!forceUpdate) isLoadingCombinedChampions = true;

    final player = ref.read(auth_provider.auth).userPlayer;

    final result = await Future.wait([
      // champions do not have forceUpdate
      // return previous value if forceUpdate
      _loadChampions(forceUpdate),
      _loadUserPlayerChampions(forceUpdate),
      player == null ? Future.value(null) : _loadFavouriteChampions(),
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
    if (result[1] != null) {
      userPlayerChampions = result[1] as List<models.PlayerChampion>;
    }
    if (result[2] != null) {
      favouriteChampions = result[2] as Set<int>;
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
    clearAppliedFiltersAndSort();
    combinedChampions = data_classes.ChampionsSort.getSortedChampions(
      combinedChampions: combinedChampions!,
      favouriteChampions: favouriteChampions,
      sort: selectedSort,
    );

    notifyListeners();
  }

  /// Get the `playerChampions` data for the playerId
  Future<void> getPlayerChampions({
    required String playerId,
    bool forceUpdate = false,
  }) async {
    isLoadingPlayerChampions = true;

    final response = await api.ChampionsRequests.playerChampions(
      playerId: playerId,
      forceUpdate: forceUpdate,
    );

    isLoadingPlayerChampions = false;
    if (response != null) {
      playerChampionsPlayerId = playerId;
      playerChampions = response.playerChampions;
    }

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
    if (response != null) {
      // set playerChampionsPlayerId to null because it doesn't belong to a specific playerId
      playerChampionsPlayerId = null;
      playerChampions = response.playerChampions;
    }

    notifyListeners();
  }

  /// Deletes the plyerChampions
  void resetPlayerChampions() {
    playerChampionsPlayerId = null;
    playerChampions = null;
  }

  /// Filters the champions based on the search provided
  void filterChampionsBySearch(String search) {
    if (combinedChampions == null) return;

    this.search = search;

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

  /// Set value of filter and apply the filter
  void setFilterValue(
    String? filterName,
    String? filterValue,
  ) {
    if (combinedChampions == null) return;

    selectedFilter = data_classes.SelectedChampionsFilter(
      name: filterName,
      value: filterValue,
    );

    combinedChampions = selectedFilter.isValid
        ? data_classes.ChampionsFilter.getFilteredChampions(
            combinedChampions: combinedChampions!,
            filter: selectedFilter,
            favouriteChampions: favouriteChampions,
          )
        : data_classes.ChampionsFilter.clearFilters(combinedChampions!);

    notifyListeners();
  }

  /// Set value of sort and apply sorting
  void setSort(String sort) {
    if (combinedChampions == null) return;

    selectedSort = sort;
    combinedChampions = data_classes.ChampionsSort.getSortedChampions(
      combinedChampions: combinedChampions!,
      favouriteChampions: favouriteChampions,
      sort: sort,
    );

    notifyListeners();
  }

  /// Fetch mark a champion favourite for the user
  Future<void> markFavouriteChampion(int championId) async {
    final favouriteChampionsClone = {...favouriteChampions};
    if (favouriteChampions.contains(championId)) {
      favouriteChampions.remove(championId);
    } else {
      favouriteChampions.add(championId);
    }
    favouriteChampions = {...favouriteChampions};
    notifyListeners();

    final response = await api.ChampionsRequests.updateFavouriteChampion(
      championId: championId,
    );
    favouriteChampions = response != null
        ? response.favouriteChampions.toSet()
        : favouriteChampionsClone;

    setSort(selectedSort);
  }

  /// Clears all applied filters and sort on combinedChampions
  void clearAppliedFiltersAndSort() {
    if (combinedChampions == null) return;

    search = "";
    combinedChampions = data_classes.ChampionsFilter.clearFilters(
      combinedChampions!,
    );
    combinedChampions = data_classes.ChampionsSort.clearSorting(
      combinedChampions!,
      favouriteChampions,
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
    search = "";
    champions = [];
    userPlayerChampions = null;
    combinedChampions = null;
    playerChampionsPlayerId = null;
    playerChampions = null;
    selectedFilter = data_classes.SelectedChampionsFilter();
    selectedSort = data_classes.ChampionsSort.defaultSort;
    favouriteChampions = {};
  }

  /// Loads the `champions` data from local db and syncs it with server
  Future<List<models.Champion>?> _loadChampions(bool forceUpdate) async {
    // try to load champions from db

    final savedChampions =
        forceUpdate ? null : utilities.Database.getChampions();
    if (savedChampions != null) return savedChampions;

    final response = await api.ChampionsRequests.allChampions();
    if (response == null) return null;

    final champions = response.champions;

    // clear the champions in db if forceUpdate
    // save champion locally for future use
    if (forceUpdate) await utilities.Database.championBox?.clear();
    champions.forEach(utilities.Database.saveChampion);

    // sort champions based on their name
    return champions.sortedBy((champion) => champion.name);
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

  /// Fetch the favourite champions for the user
  Future<Set<int>?> _loadFavouriteChampions() async {
    final response = await api.ChampionsRequests.favouriteChampions();

    return response?.favouriteChampions.toSet();
  }
}

/// Provider to handle champions
final champions = ChangeNotifierProvider<_ChampionsNotifier>(
  (ref) => _ChampionsNotifier(ref: ref),
);
