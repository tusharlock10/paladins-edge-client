import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/api/index.dart" as api;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/utilities/index.dart" as utilities;

class _MatchesNotifier extends ChangeNotifier {
  bool isPlayerMatchesLoading = false;
  bool isMatchDetailsLoading = false;
  api.PlayerMatchesResponse? playerMatches;
  api.MatchDetailsResponse? matchDetails;
  List<data_classes.CombinedMatch>? combinedMatches;

  /// holds the currently active sort
  String selectedSort = data_classes.MatchSort.defaultSort;

  /// holds the currently active filter
  data_classes.SelectedMatchFilter selectedFilter =
      data_classes.SelectedMatchFilter();

  Future<void> getPlayerMatches({
    required String playerId,
    bool forceUpdate = false,
  }) async {
    if (!forceUpdate) {
      isPlayerMatchesLoading = true;
      utilities.postFrameCallback(notifyListeners);
    }

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

    // sort combinedMatches based on the selectedSort
    if (combinedMatches != null) {
      combinedMatches = data_classes.MatchSort.getSortedMatches(
        combinedMatches: combinedMatches!,
        sort: selectedSort,
      );
    }

    if (!forceUpdate) isPlayerMatchesLoading = false;

    notifyListeners();
  }

  Future<void> getMatchDetails(String matchId) async {
    isMatchDetailsLoading = true;
    utilities.postFrameCallback(notifyListeners);

    final response = await api.MatchRequests.matchDetails(matchId: matchId);

    isMatchDetailsLoading = false;
    matchDetails = response;

    // sort players based on their team
    matchDetails?.matchPlayers.sort((a, b) => a.team.compareTo(b.team));

    notifyListeners();
  }

  void resetMatchDetails() {
    matchDetails = null;

    utilities.postFrameCallback(notifyListeners);
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

  /// Set the name of filter
  void setFilterName(String filterName) {
    selectedFilter = data_classes.SelectedMatchFilter(name: filterName);

    notifyListeners();
  }

  /// Set value of filter and apply the filter
  void setFilterValue(data_classes.MatchFilterValue? filterValue) {
    if (combinedMatches == null) return;

    selectedFilter = data_classes.SelectedMatchFilter(
      name: selectedFilter.name,
      value: filterValue,
    );

    combinedMatches = selectedFilter.isValid
        ? data_classes.MatchFilter.getFilteredMatches(
            combinedMatches: combinedMatches!,
            filter: selectedFilter,
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

  /// Clears all user sensitive data upon logout
  void clearData() {
    isPlayerMatchesLoading = false;
    isMatchDetailsLoading = false;
    playerMatches = null;
    matchDetails = null;
  }
}

/// Provider to handle matches
final matches = ChangeNotifierProvider((_) => _MatchesNotifier());
