import "package:dartx/dartx.dart";
import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/api/index.dart" as api;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/auth.dart" as auth_provider;
import "package:paladinsedge/providers/champions.dart" as champions_provider;
import "package:paladinsedge/utilities/index.dart" as utilities;

class _MatchesNotifier extends ChangeNotifier {
  final ChangeNotifierProviderRef<_MatchesNotifier> ref;

  /// Match detail
  bool isMatchDetailsLoading = false;
  data_classes.MatchData? matchDetails;

  /// Player matches
  bool isPlayerMatchesLoading = false;
  int? combinedMatchesPlayerId;
  List<data_classes.CombinedMatch>? combinedMatches;

  /// Saved Matches
  List<data_classes.CombinedMatch>? savedMatches;

  /// Common matches
  bool isCommonMatchesLoading = false;
  int? commonMatchesPlayerId;
  List<data_classes.CombinedMatch>? commonMatches;

  /// Top matches
  bool isTopMatchesLoading = true;
  List<models.TopMatch>? topMatches;

  /// Matches filter and sorting
  String selectedSort = data_classes.MatchSort.defaultSort;
  data_classes.SelectedMatchFilter selectedFilter =
      data_classes.SelectedMatchFilter();

  _MatchesNotifier({required this.ref});

  void resetPlayerMatches({bool forceUpdate = false}) {
    if (forceUpdate) return;

    isPlayerMatchesLoading = true;
    combinedMatches = null;
    combinedMatchesPlayerId = null;
    utilities.postFrameCallback(notifyListeners);
  }

  /// get the matches for this playerId
  Future<void> getPlayerMatches({
    required int playerId,
    bool forceUpdate = false,
  }) async {
    final response = await api.MatchRequests.playerMatches(
      playerId: playerId,
      forceUpdate: forceUpdate,
    );
    if (!forceUpdate) isPlayerMatchesLoading = false;

    if (!response.success) return notifyListeners();
    final matchesData = response.data!;

    // create list of combinedMatches using a temp. map
    final Map<int, data_classes.CombinedMatch> tempMatchesMap = {};
    for (final match in matchesData.matches) {
      tempMatchesMap[match.matchId] = data_classes.CombinedMatch(
        match: match,
        matchPlayers: [],
      );
    }
    for (final matchPlayer in matchesData.matchPlayers) {
      final existingCombinedMatch = tempMatchesMap[matchPlayer.matchId];
      if (existingCombinedMatch == null) continue;

      tempMatchesMap[matchPlayer.matchId] = existingCombinedMatch.copyWith(
        matchPlayers: [...existingCombinedMatch.matchPlayers, matchPlayer],
      );
    }

    combinedMatchesPlayerId = playerId;
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

  Future<void> getMatchDetails(int matchId) async {
    isMatchDetailsLoading = true;
    utilities.postFrameCallback(notifyListeners);

    final response = await api.MatchRequests.matchDetails(matchId: matchId);

    isMatchDetailsLoading = false;
    matchDetails = response.data;

    // sort players based on their team
    matchDetails?.matchPlayers.sort((a, b) => a.team.compareTo(b.team));

    final index = combinedMatches?.indexWhere(
      (combinedMatch) =>
          combinedMatch.match.matchId == matchDetails?.match.matchId,
    );
    if (index != null &&
        index >= 0 &&
        combinedMatches != null &&
        matchDetails != null) {
      final combinedMatch = combinedMatches!.elementAt(index);
      if (combinedMatch.match.isInComplete) {
        combinedMatches![index] = data_classes.CombinedMatch(
          match: matchDetails!.match,
          matchPlayers: matchDetails!.matchPlayers,
          hide: combinedMatch.hide,
        );
        combinedMatches = [...combinedMatches!];
      }
    }

    notifyListeners();
  }

  /// Gets all the saved matches for this user
  Future<void> getSavedMatches() async {
    final user = ref.read(auth_provider.auth).user;
    final response = await api.MatchRequests.savedMatches();
    print("RESPONSE IS ::: ${response.data}");
    if (!response.success) return;

    // create list of combinedMatches using a temp. map
    final matchesData = response.data!;
    final Map<int, data_classes.CombinedMatch> tempMatchesMap = {};
    for (final match in matchesData.matches) {
      tempMatchesMap[match.matchId] = data_classes.CombinedMatch(
        match: match,
        matchPlayers: [],
      );
    }
    for (final matchPlayer in matchesData.matchPlayers) {
      final existingCombinedMatch = tempMatchesMap[matchPlayer.matchId];
      if (existingCombinedMatch == null) continue;

      tempMatchesMap[matchPlayer.matchId] = existingCombinedMatch.copyWith(
        matchPlayers: [...existingCombinedMatch.matchPlayers, matchPlayer],
      );
    }

    savedMatches = tempMatchesMap.values.toList();
    if (user != null && savedMatches != null) {
      final matchIds = savedMatches!.map((_) => _.match.matchId);
      user.savedMatchIds = List<int>.from(matchIds);
      utilities.Database.saveUser(user);
    }
    notifyListeners();
  }

  /// Saves/ Un-saves a `match` for later reference
  Future<data_classes.SaveMatchResult> saveMatch(
    int matchId,
  ) async {
    final user = ref.read(auth_provider.auth).user;
    if (user == null) return data_classes.SaveMatchResult.unauthorized;

    data_classes.SaveMatchResult result;
    data_classes.CombinedMatch? combinedMatch = savedMatches?.firstOrNullWhere(
      (_) => _.match.matchId == matchId,
    );
    if (combinedMatch == null) {
      if (matchDetails != null && matchDetails!.match.matchId == matchId) {
        combinedMatch = data_classes.CombinedMatch(
          match: matchDetails!.match,
          matchPlayers: matchDetails!.matchPlayers,
        );
      }
    }
    if (combinedMatch == null) return data_classes.SaveMatchResult.reverted;

    final savedMatchesClone = List<int>.from(user.savedMatchIds);

    if (!user.savedMatchIds.contains(matchId)) {
      // matchId is not in savedMatches, so we need to add it

      // check if user already has max number of saved matches
      if (user.favouriteFriendIds.length >=
          utilities.Global.essentials!.maxSavedMatches) {
        return data_classes.SaveMatchResult.limitReached;
      }

      user.savedMatchIds.add(matchId);
      result = data_classes.SaveMatchResult.added;
      savedMatches = [...?savedMatches, combinedMatch];
    } else {
      // if match is in savedMatches, then remove it
      user.savedMatchIds.remove(matchId);
      result = data_classes.SaveMatchResult.removed;
      if (savedMatches != null) {
        savedMatches = savedMatches!
            .where(
              (_) => _.match.matchId != matchId,
            )
            .toList();
      }
    }

    notifyListeners();

    // after we update the UI
    // update the saved matches in backend
    // update the UI for the latest changes from backend

    final response = await api.MatchRequests.saveMatch(
      matchId: matchId,
    );

    if (!response.success) {
      // if the response fails for some reason, revert back the change
      user.savedMatchIds = savedMatchesClone;
      _restoreSavedMatches(combinedMatch, result);

      result = data_classes.SaveMatchResult.reverted;
    }

    notifyListeners();
    utilities.Database.saveUser(user);

    return result;
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

  /// Set value of filter and apply the filter
  void setFilterValue(
    String? filterName,
    data_classes.MatchFilterValue? filterValue,
  ) {
    if (combinedMatches == null || combinedMatchesPlayerId == null) return;

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
            playerId: combinedMatchesPlayerId!,
          )
        : data_classes.MatchFilter.clearFilters(combinedMatches!);

    notifyListeners();
  }

  void getCommonMatches({
    required int userPlayerId,
    required int playerId,
  }) async {
    isCommonMatchesLoading = true;
    commonMatchesPlayerId = playerId;
    utilities.postFrameCallback(notifyListeners);

    final response = await api.MatchRequests.commonMatches(
      playerIds: [userPlayerId, playerId],
    );
    if (!response.success) {
      isCommonMatchesLoading = false;
      commonMatches = null;
      notifyListeners();

      return;
    }
    final matchesData = response.data!;

    // create list of commonMatches using a temp. map
    final Map<int, data_classes.CombinedMatch> tempMatchesMap = {};
    for (final match in matchesData.matches) {
      tempMatchesMap[match.matchId] = data_classes.CombinedMatch(
        match: match,
        matchPlayers: [],
      );
    }
    for (final matchPlayer in matchesData.matchPlayers) {
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

  /// Loads the `topMatches` data from local db and syncs it with server
  Future<void> loadTopMatches(bool forceUpdate) async {
    final savedTopMatches =
        forceUpdate ? null : utilities.Database.getTopMatches();

    if (savedTopMatches != null) {
      isTopMatchesLoading = false;
      topMatches = savedTopMatches;

      return utilities.postFrameCallback(notifyListeners);
    }

    final response = await api.MatchRequests.topMatches();
    if (!response.success) return;

    isTopMatchesLoading = false;
    topMatches = response.data;
    notifyListeners();

    // save topMatches locally for future use
    // clear topMatches first if forceUpdate
    if (forceUpdate) await utilities.Database.topMatchBox?.clear();
    topMatches?.forEach(utilities.Database.saveTopMatch);
  }

  /// Clears all user sensitive data upon logout
  void clearData() {
    isPlayerMatchesLoading = false;
    isMatchDetailsLoading = false;
    isCommonMatchesLoading = false;
    matchDetails = null;
    combinedMatchesPlayerId = null;
    combinedMatches = null;
    commonMatchesPlayerId = null;
    commonMatches = null;
  }

  void _restoreSavedMatches(
    data_classes.CombinedMatch combinedMatch,
    data_classes.SaveMatchResult result,
  ) {
    if (savedMatches == null) return;

    savedMatches = result == data_classes.SaveMatchResult.added
        ? savedMatches!
            .where((_) => _.match.matchId != combinedMatch.match.matchId)
            .toList()
        : [...savedMatches!, combinedMatch];
  }
}

/// Provider to handle matches
final matches = ChangeNotifierProvider((ref) => _MatchesNotifier(ref: ref));
