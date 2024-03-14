import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/api/index.dart" as api;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/auth.dart" as auth_provider;
import "package:paladinsedge/providers/champions.dart" as champions_provider;
import "package:paladinsedge/providers/search.dart" as search_provider;
import "package:paladinsedge/utilities/index.dart" as utilities;

class _PlayersNotifier extends ChangeNotifier {
  // Loading
  bool isLoadingPlayerData = false;
  bool isLoadingPlayerStatus = false;
  bool isLoadingPlayerInferred = false;
  bool isPlayerMatchesLoading = false;
  bool isCommonMatchesLoading = false;

  // Player related data
  int? playerStreak;
  models.Player? playerData;
  api.PlayerStatusResponse? playerStatus;
  models.PlayerInferred? playerInferred;
  List<data_classes.CombinedMatch>? combinedMatches;
  List<data_classes.CombinedMatch>? commonMatches;
  data_classes.PlayerTimedStats? timedStats;

  /// Matches filter and sorting
  String selectedSort = data_classes.MatchSort.defaultSort;
  data_classes.SelectedMatchFilter selectedFilter =
      data_classes.SelectedMatchFilter();

  final String playerId;
  final ChangeNotifierProviderRef<_PlayersNotifier> ref;

  _PlayersNotifier({
    required this.playerId,
    required this.ref,
  });

  /// get the playerStatus from api
  /// [onlyStatus] param if false, will get the active match details as well
  /// else it will not get the active match details
  Future<void> getPlayerStatus({
    bool forceUpdate = false,
    bool onlyStatus = false,
  }) async {
    if (!forceUpdate) {
      isLoadingPlayerStatus = true;
      utilities.postFrameCallback(notifyListeners);
    }

    playerStatus = await api.PlayersRequests.playerStatus(
      playerId: playerId,
      onlyStatus: onlyStatus,
    );

    playerStatus ??= api.PlayerStatusResponse(
      inMatch: false,
      playerId: "0",
      status: "Unknown",
      match: null,
    );

    if (!forceUpdate) isLoadingPlayerStatus = false;
    notifyListeners();
  }

  /// get the playerInferred from the api
  Future<void> getPlayerInferred() async {
    isLoadingPlayerInferred = true;
    utilities.postFrameCallback(notifyListeners);

    final response = await api.PlayersRequests.playerInferred(
      playerId: playerId,
    );
    playerInferred = response?.playerInferred;

    isLoadingPlayerInferred = false;
    notifyListeners();
  }

  Future<void> getPlayerData({required bool forceUpdate}) async {
    if (!forceUpdate) {
      isLoadingPlayerData = true;
      utilities.postFrameCallback(notifyListeners);
    }

    final response = await api.PlayersRequests.playerDetail(
      playerId: playerId,
      forceUpdate: forceUpdate,
    );

    if (response == null) {
      if (!forceUpdate) isLoadingPlayerData = false;
      notifyListeners();

      return;
    }

    playerData = response.player;

    final searchProvider = ref.read(search_provider.search);
    await searchProvider.insertSearchHistory(
      playerName: playerData!.name,
      playerId: playerId,
    );

    if (!forceUpdate) isLoadingPlayerData = false;
    notifyListeners();
  }

  /// get the matches for this playerId
  Future<void> getPlayerMatches({bool forceUpdate = false}) async {
    final response = await api.MatchRequests.playerMatches(
      playerId: playerId,
      forceUpdate: forceUpdate,
    );
    if (!forceUpdate) isPlayerMatchesLoading = false;

    if (response == null) return notifyListeners();

    // create list of combinedMatches using a temp. map
    final Map<String, data_classes.CombinedMatch> tempMatchesMap = {};
    for (final match in response.matches) {
      tempMatchesMap[match.matchId] = data_classes.CombinedMatch(
        match: match,
        matchPlayers: [],
      );
    }
    for (final matchPlayer in response.matchPlayers) {
      final existingCombinedMatch = tempMatchesMap[matchPlayer.matchId];
      if (existingCombinedMatch == null) continue;

      tempMatchesMap[matchPlayer.matchId] = existingCombinedMatch.copyWith(
        matchPlayers: [...existingCombinedMatch.matchPlayers, matchPlayer],
      );
    }

    combinedMatches = tempMatchesMap.values.toList();

    // sort combinedMatches based on the default sorting (i.e. sorting by date)
    if (combinedMatches != null) {
      combinedMatches = data_classes.MatchSort.getSortedMatches(
        combinedMatches: combinedMatches!,
        sort: data_classes.MatchSort.defaultSort,
      );
      playerStreak = utilities.getPlayerStreak(combinedMatches!, playerId);
      timedStats = utilities.getPlayerTimedStats(
        combinedMatches!,
        data_classes.TimedStatsType.days1,
        playerId,
      );
      print("TIMED :: ${timedStats!.totalMatches}");
      print("TIMED TOTAL :: ${timedStats!.totalStats.kills}");
      print("TIMED AVG :: ${timedStats!.averageStats.kills}");
    }

    if (!forceUpdate) isPlayerMatchesLoading = false;

    notifyListeners();
  }

  void getCommonMatches() async {
    final userPlayerId = ref.read(auth_provider.auth).userPlayer?.playerId;
    if (userPlayerId == null) return;

    isCommonMatchesLoading = true;
    utilities.postFrameCallback(notifyListeners);

    final response = await api.MatchRequests.commonMatches(
      playerIds: [userPlayerId, playerId],
    );
    if (response == null) {
      isCommonMatchesLoading = false;
      commonMatches = null;
      notifyListeners();

      return;
    }

    // create list of commonMatches using a temp. map
    final Map<String, data_classes.CombinedMatch> tempMatchesMap = {};
    for (final match in response.matches) {
      tempMatchesMap[match.matchId] = data_classes.CombinedMatch(
        match: match,
        matchPlayers: [],
      );
    }
    for (final matchPlayer in response.matchPlayers) {
      final existingCombinedMatch = tempMatchesMap[matchPlayer.matchId];
      if (existingCombinedMatch == null) continue;

      tempMatchesMap[matchPlayer.matchId] = existingCombinedMatch.copyWith(
        matchPlayers: [...existingCombinedMatch.matchPlayers, matchPlayer],
      );
    }

    isCommonMatchesLoading = false;
    commonMatches = tempMatchesMap.values.toList();

    // sort commonMatches based on date
    if (commonMatches != null) {
      commonMatches = data_classes.MatchSort.getSortedMatches(
        combinedMatches: commonMatches!,
        sort: data_classes.MatchSort.defaultSort,
      );
    }

    notifyListeners();
  }

  /// Set value of sort and apply sorting
  void setSort(String sort) {
    if (combinedMatches == null) return;

    selectedSort = sort;
    combinedMatches = data_classes.MatchSort.getSortedMatches(
      combinedMatches: combinedMatches!,
      sort: sort,
    );

    notifyListeners();
  }

  /// Set value of filter and apply the filter
  void setFilterValue(
    String? filterName,
    data_classes.MatchFilterValue? filterValue,
  ) {
    if (combinedMatches == null) return;

    selectedFilter = data_classes.SelectedMatchFilter(
      name: filterName,
      value: filterValue,
    );
    final champions = ref.read(champions_provider.champions).champions;

    combinedMatches = selectedFilter.isValid
        ? data_classes.MatchFilter.getFilteredMatches(
            combinedMatches: combinedMatches!,
            filter: selectedFilter,
            champions: champions,
            playerId: playerId,
          )
        : data_classes.MatchFilter.clearFilters(combinedMatches!);

    notifyListeners();
  }

  /// Clears all applied filters and sort on combinedMatches
  void clearAppliedFiltersAndSort() {
    if (combinedMatches == null) return;

    combinedMatches = data_classes.MatchFilter.clearFilters(combinedMatches!);
    combinedMatches = data_classes.MatchSort.clearSorting(combinedMatches!);
    selectedFilter = data_classes.SelectedMatchFilter(
      name: selectedFilter.name,
    );
    selectedSort = data_classes.MatchSort.defaultSort;

    utilities.postFrameCallback(notifyListeners);
  }

  void resetPlayerStatus() {
    playerStatus = null;
    isLoadingPlayerStatus = false;

    utilities.postFrameCallback(notifyListeners);
  }

  void resetPlayerMatches({bool forceUpdate = false}) {
    if (forceUpdate) return;

    isPlayerMatchesLoading = true;
    combinedMatches = null;
    playerStreak = null;
    utilities.postFrameCallback(notifyListeners);
  }
}

/// Provider to handle players
final players = ChangeNotifierProvider.family<_PlayersNotifier, String>(
  (ref, playerId) => _PlayersNotifier(ref: ref, playerId: playerId),
);
