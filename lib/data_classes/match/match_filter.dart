import "package:paladinsedge/data_classes/match/combined_match.dart";
import "package:paladinsedge/data_classes/match/match_filter_value.dart";
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;

class SelectedMatchFilter {
  final String? name;
  final MatchFilterValue? value;

  bool get isValid {
    return value != null && name != null;
  }

  SelectedMatchFilter({
    this.name,
    this.value,
  });
}

abstract class MatchFilter {
  static const _map = "Map";
  static const _betweenDates = "Between Dates";
  static const _queue = "Queue";
  static const _roles = "Roles";

  static List<String> get filterNames => [
        _map,
        _betweenDates,
        _queue,
        _roles,
      ];

  static List<MatchFilterValue>? getFilterValues(
    String filter,
  ) {
    switch (filter) {
      case _map:
        return MatchFilterValues.map;
      case _betweenDates:
        return MatchFilterValues.betweenDates;
      case _queue:
        return MatchFilterValues.queue;
      case _roles:
        return MatchFilterValues.roles;
      default:
        return null;
    }
  }

  static String getFilterDescription(
    String filter,
  ) {
    switch (filter) {
      case _map:
        return "Filter matches by map";
      case _betweenDates:
        return "Filter matches from certain dates";
      case _queue:
        return "Filter matches based on their queue";
      case _roles:
        return "Filter matches based on role of champion played";
      default:
        return "";
    }
  }

  static List<CombinedMatch> getFilteredMatches({
    required List<CombinedMatch> combinedMatches,
    required SelectedMatchFilter filter,
    required List<models.Champion> champions,
    required String playerId,
  }) {
    switch (filter.name) {
      case _map:
        return _filterByMap(combinedMatches, filter);
      case _betweenDates:
        return _filterByBetweenDates(combinedMatches, filter);
      case _queue:
        return _filterByQueue(combinedMatches, filter);
      case _roles:
        return _filterByRoles(combinedMatches, filter, champions, playerId);
      default:
        return combinedMatches;
    }
  }

  static List<CombinedMatch> clearFilters(
    List<CombinedMatch> combinedMatches,
  ) =>
      combinedMatches
          .map((combinedMatch) => combinedMatch.copyWith(hide: false))
          .toList();

  static List<CombinedMatch> _filterByMap(
    List<CombinedMatch> combinedMatches,
    SelectedMatchFilter filter,
  ) =>
      combinedMatches
          .map(
            (combinedMatch) => combinedMatch.copyWith(
              hide:
                  !combinedMatch.match.map.contains(filter.value?.value ?? ""),
            ),
          )
          .toList();

  static List<CombinedMatch> _filterByBetweenDates(
    List<CombinedMatch> combinedMatches,
    SelectedMatchFilter filter,
  ) {
    DateTime? startDate = filter.value?.dateValue["startDate"];
    DateTime? endDate = filter.value?.dateValue["endDate"];
    if (startDate == null && endDate == null) return combinedMatches;

    if (startDate == null || endDate == null) {
      startDate = startDate ?? endDate;
      endDate = startDate!.add(const Duration(days: 1));
    }

    return combinedMatches.map(
      (combinedMatch) {
        final matchDateTime = combinedMatch.match.matchStartTime;
        final hide = matchDateTime.isBefore(startDate!) ||
            matchDateTime.isAfter(endDate!);

        return combinedMatch.copyWith(hide: hide);
      },
    ).toList();
  }

  static List<CombinedMatch> _filterByQueue(
    List<CombinedMatch> combinedMatches,
    SelectedMatchFilter filter,
  ) {
    if (filter.value == null) return combinedMatches;

    if (filter.value!.valueName == "Other") {
      final queueValues = MatchFilterValues.queue.map((_) => _.value);

      return combinedMatches
          .map(
            (combinedMatch) => combinedMatch.copyWith(
              hide: queueValues.contains(combinedMatch.match.queue),
            ),
          )
          .toList();
    }

    return combinedMatches
        .map(
          (combinedMatch) => combinedMatch.copyWith(
            hide: !combinedMatch.match.queue.contains(filter.value!.value),
          ),
        )
        .toList();
  }

  static List<CombinedMatch> _filterByRoles(
    List<CombinedMatch> combinedMatches,
    SelectedMatchFilter filter,
    List<models.Champion> champions,
    String playerId,
  ) {
    if (filter.value == null) return combinedMatches;
    final roleChampionIds = champions
        .where((_) => _.role == filter.value!.value)
        .map((_) => _.championId);
    final roleChampionIdsSet = Set.from(roleChampionIds);

    return combinedMatches.map(
      (combinedMatch) {
        final matchPlayer = utilities.getMatchPlayerFromPlayerId(
          combinedMatch.matchPlayers,
          playerId,
        );
        if (matchPlayer == null) return combinedMatch;

        return combinedMatch.copyWith(
          hide: !roleChampionIdsSet.contains(matchPlayer.championId),
        );
      },
    ).toList();
  }
}
