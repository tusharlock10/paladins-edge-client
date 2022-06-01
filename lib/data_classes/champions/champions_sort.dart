import "package:dartx/dartx.dart";
import "package:jiffy/jiffy.dart";
import "package:paladinsedge/data_classes/champions/combined_champion.dart";

abstract class ChampionsSort {
  static const _name = "Name";
  static const _level = "Level";
  static const _health = "Health";
  static const _winRate = "Win Rate";
  static const _releasedDate = "Release Date";
  static const _dps = "DPS";
  static const _lastPlayed = "Last Played";

  static String get defaultSort => _name;

  static List<String> championSorts(bool isGuest) => isGuest
      ? [
          _name,
          _health,
          _releasedDate,
          _dps,
        ]
      : [
          _name,
          _health,
          _releasedDate,
          _dps,
          _level,
          _winRate,
          _lastPlayed,
        ];

  static List<CombinedChampion> getSortedChampions({
    required List<CombinedChampion> combinedChampions,
    required String sort,
  }) {
    switch (sort) {
      case _name:
        return _sortByName(combinedChampions);
      case _health:
        return _sortByHealth(combinedChampions);
      case _releasedDate:
        return _sortByReleaseDate(combinedChampions);
      case _dps:
        return _sortByDPS(combinedChampions);
      case _level:
        return _sortByLevel(combinedChampions);
      case _winRate:
        return _sortByWinRate(combinedChampions);
      case _lastPlayed:
        return _sortByLastPlayed(combinedChampions);
      default:
        return combinedChampions;
    }
  }

  static String getSortDescription(String sort) {
    switch (sort) {
      case _name:
        return "Sort champions based on their name (Default)";
      case _health:
        return "Sort champions based on their health";
      case _releasedDate:
        return "Sort champions on day they were released";
      case _dps:
        return "Sort champions based on their damage output";
      case _level:
        return "Sort champions that based on their level in your account";
      case _winRate:
        return "Sort champions based on your win-rate using them";
      case _lastPlayed:
        return "Sort champions based on when you last played them";
      default:
        return "";
    }
  }

  static String? getSortTextChipValue({
    required CombinedChampion combinedChampion,
    required String sort,
  }) {
    switch (sort) {
      case _name:
        return null;
      case _health:
        return "Health ${combinedChampion.champion.health.toInt()}";
      case _releasedDate:
        final formattedReleaseDate =
            Jiffy(combinedChampion.champion.releaseDate).format("MMM do yy");
        return "Released on $formattedReleaseDate";
      case _dps:
        final dps = combinedChampion.champion.weaponDamage ~/
            combinedChampion.champion.fireRate;
        return "DPS $dps";
      case _level:
        return null;
      case _winRate:
        if (combinedChampion.playerChampion == null) return "Not Played";
        final playerChampion = combinedChampion.playerChampion!;
        final matches = playerChampion.wins + playerChampion.losses;
        if (matches == 0) return null;
        final winRate = playerChampion.wins * 100 / matches;

        return "WR ${winRate.toStringAsPrecision(3)}%";
      case _lastPlayed:
        if (combinedChampion.playerChampion == null) return "Not Played";
        final formattedLastPlayed =
            Jiffy(combinedChampion.playerChampion!.lastPlayed).format("MMM do");
        return "Played on $formattedLastPlayed";
      default:
        return "";
    }
  }

  static List<CombinedChampion> clearSorting(
    List<CombinedChampion> combinedChampions,
  ) =>
      _sortByName(combinedChampions);

  static List<CombinedChampion> _sortByName(
    List<CombinedChampion> combinedChampions,
  ) =>
      combinedChampions
          .sortedWith((a, b) => a.champion.name.compareTo(b.champion.name))
          .toList();

  static List<CombinedChampion> _sortByHealth(
    List<CombinedChampion> combinedChampions,
  ) =>
      combinedChampions
          .sortedWith((a, b) => a.champion.health.compareTo(b.champion.health))
          .toList();

  static List<CombinedChampion> _sortByReleaseDate(
    List<CombinedChampion> combinedChampions,
  ) =>
      combinedChampions
          .sortedWith((a, b) =>
              a.champion.releaseDate.compareTo(b.champion.releaseDate))
          .toList();

  static List<CombinedChampion> _sortByDPS(
    List<CombinedChampion> combinedChampions,
  ) =>
      combinedChampions.sortedWith((a, b) {
        final aDPS = a.champion.weaponDamage / a.champion.fireRate;
        final bDPS = b.champion.weaponDamage / b.champion.fireRate;

        return aDPS.compareTo(bDPS);
      }).toList();

  static List<CombinedChampion> _sortByLevel(
    List<CombinedChampion> combinedChampions,
  ) {
    final nonNullCombinedChampions =
        combinedChampions.filter((_) => _.playerChampion?.level != null);
    final nullCombinedChampions =
        combinedChampions.filter((_) => _.playerChampion?.level == null);

    return [
      ...nonNullCombinedChampions.sortedWith((a, b) {
        return a.playerChampion!.level.compareTo(b.playerChampion!.level);
      }),
      ...nullCombinedChampions,
    ];
  }

  static List<CombinedChampion> _sortByWinRate(
    List<CombinedChampion> combinedChampions,
  ) {
    final nonNullCombinedChampions = combinedChampions.filter((_) =>
        _.playerChampion?.wins != null && _.playerChampion?.losses != null);
    final nullCombinedChampions = combinedChampions.filter((_) =>
        _.playerChampion?.wins == null || _.playerChampion?.losses == null);

    return [
      ...nonNullCombinedChampions.sortedWith((a, b) {
        final apc = a.playerChampion!;
        final bpc = b.playerChampion!;

        final aMatches = apc.wins + apc.losses;
        final bMatches = bpc.wins + bpc.losses;

        final aWinRate = apc.wins * 100 / aMatches;
        final bWinRate = bpc.wins * 100 / bMatches;

        return aWinRate.compareTo(bWinRate);
      }),
      ...nullCombinedChampions,
    ];
  }

  static List<CombinedChampion> _sortByLastPlayed(
    List<CombinedChampion> combinedChampions,
  ) {
    final nonNullCombinedChampions =
        combinedChampions.filter((_) => _.playerChampion?.lastPlayed != null);
    final nullCombinedChampions =
        combinedChampions.filter((_) => _.playerChampion?.lastPlayed == null);

    return [
      ...nonNullCombinedChampions.sortedWith((a, b) {
        return a.playerChampion!.lastPlayed
            .compareTo(b.playerChampion!.lastPlayed);
      }),
      ...nullCombinedChampions,
    ];
  }
}
