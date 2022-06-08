import "package:jiffy/jiffy.dart";
import "package:paladinsedge/data_classes/match/combined_match.dart";

enum MatchFilterValueType { normal, dates }

class MatchFilterValue {
  final String value;
  final Map<String, DateTime?> dateValue;
  final MatchFilterValueType type;
  final String _valueName;

  String get valueName =>
      type == MatchFilterValueType.dates ? _getDateValueName() : _valueName;

  MatchFilterValue({
    required String valueName,
    required this.value,
    this.dateValue = const {},
    this.type = MatchFilterValueType.normal,
  }) : _valueName = valueName;

  bool isSameFilter(MatchFilterValue? other) {
    if (other == null) return false;
    if (other.type != type) return false;
    if (value != other.value) return false;

    // for date, just check if both types are equal
    if (other.type == MatchFilterValueType.dates &&
        type == MatchFilterValueType.dates) return true;

    return true;
  }

  String _getDateValueName() {
    final startDate = dateValue["startDate"];
    final endDate = dateValue["endDate"];
    if (startDate == null && endDate == null) return _valueName;
    const formatStringLong = "MMM do yyyy";
    const formatStringShort = "MMM d";

    if (endDate == null) return Jiffy(startDate).format(formatStringLong);
    if (startDate == null) return Jiffy(endDate).format(formatStringLong);

    return "${Jiffy(startDate).format(formatStringShort)} - ${Jiffy(endDate).format(formatStringShort)}";
  }
}

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

  static List<String> get filterNames => [_map, _betweenDates, _queue];

  static List<MatchFilterValue>? getFilterValues(
    String filter,
  ) {
    switch (filter) {
      case _map:
        return [
          MatchFilterValue(valueName: "SG: BM", value: "Brightmarsh"),
          MatchFilterValue(valueName: "SG: FM", value: "Fish Market"),
          MatchFilterValue(valueName: "SG: SB", value: "Serpent Beach"),
          MatchFilterValue(valueName: "SG: SK(D)", value: "Stone Keep (Day)"),
          MatchFilterValue(valueName: "SG: SK(N)", value: "Stone Keep (Night)"),
          MatchFilterValue(valueName: "SG: WG", value: "Warder's Gate"),
          MatchFilterValue(valueName: "SG: SD", value: "Shattered Desert"),
          MatchFilterValue(valueName: "SG: FG", value: "Frozen Guard "),
          MatchFilterValue(valueName: "SG: TM", value: "Timber Mill"),
          MatchFilterValue(valueName: "SG: AP", value: "Ascension Peak"),
          MatchFilterValue(valueName: "SG: FI", value: "Frog Isle"),
          MatchFilterValue(valueName: "SG: JF", value: "Jaguar Falls"),
          MatchFilterValue(valueName: "SG: SQ", value: "Splitstone Quarry"),
          MatchFilterValue(valueName: "SG: IM", value: "Ice Mines"),
          MatchFilterValue(valueName: "SG: BZR", value: "Bazaar"),
          MatchFilterValue(valueName: "TDM: DA", value: "Dragon Arena"),
          MatchFilterValue(valueName: "TDM: TD", value: "Trade District"),
          MatchFilterValue(valueName: "TDM: SJ", value: "Snowfall Junction"),
          MatchFilterValue(valueName: "TDM: ABS", value: "Abyss"),
          MatchFilterValue(
            valueName: "ONS: MA",
            value: "Magistrate's Archives",
          ),
          MatchFilterValue(valueName: "ONS: MP", value: "Marauder's Port"),
          MatchFilterValue(valueName: "ONS: FR", value: "Foreman's Rise"),
          MatchFilterValue(valueName: "ONS: PC", value: "Primal Court"),
        ];
      case _betweenDates:
        return [
          MatchFilterValue(
            value: "Select Dates",
            valueName: "Select Dates",
            type: MatchFilterValueType.dates,
          ),
        ];
      case _queue:
        return [
          MatchFilterValue(value: "Casual Siege", valueName: "SG"),
          MatchFilterValue(value: "Team Deathmatch ", valueName: "TDM"),
          MatchFilterValue(value: "Onslaught", valueName: "ONS"),
          MatchFilterValue(value: "Ranked Keyboard", valueName: "RNK: KBM"),
          MatchFilterValue(value: "Ranked Controller ", valueName: "RNK: CON"),
          MatchFilterValue(value: "Siege: Beyond", valueName: "SG: BYD"),
        ];
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
      default:
        return "";
    }
  }

  static List<CombinedMatch> getFilteredMatches({
    required List<CombinedMatch> combinedMatches,
    required SelectedMatchFilter filter,
  }) {
    switch (filter.name) {
      case _map:
        return _filterByMap(combinedMatches, filter);
      case _betweenDates:
        return _filterByBetweenDates(combinedMatches, filter);
      case _queue:
        return _filterByQueue(combinedMatches, filter);
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
  ) =>
      filter.value == null
          ? combinedMatches
          : combinedMatches
              .map(
                (combinedMatch) => combinedMatch.copyWith(
                  hide:
                      !combinedMatch.match.queue.contains(filter.value!.value),
                ),
              )
              .toList();
}
