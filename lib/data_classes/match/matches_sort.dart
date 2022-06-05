import "package:dartx/dartx.dart";
import "package:paladinsedge/data_classes/match/combined_match.dart";

abstract class MatchSort {
  static const matchSorts = [
    _date,
    _kills,
    _deaths,
    _damage,
    _healing,
    _damageTaken,
  ];
  static const _date = "Date";
  static const _kills = "Kills";
  static const _deaths = "Deaths";
  static const _damage = "Damage";
  static const _healing = "Healing";
  static const _damageTaken = "Damage Taken";

  static String get defaultSort => _date;

  static List<CombinedMatch> getSortedMatches({
    required List<CombinedMatch> combinedMatches,
    required String sort,
  }) {
    switch (sort) {
      case _date:
        return _sortByDate(combinedMatches);
      case _kills:
        return _sortByKills(combinedMatches);
      case _deaths:
        return _sortByDeaths(combinedMatches);
      case _damage:
        return _sortByDamage(combinedMatches);
      case _healing:
        return _sortByHealing(combinedMatches);
      case _damageTaken:
        return _sortByDamageTaken(combinedMatches);
      default:
        return combinedMatches;
    }
  }

  static String getSortDescription(String sort) {
    switch (sort) {
      case _date:
        return "Sort matches based on their date (Default)";
      case _kills:
        return "Sort matches based on kills by this player";
      case _deaths:
        return "Sort matches based on deaths of this player";
      case _damage:
        return "Sort matches based on the damage dealt by this player in a match";
      case _healing:
        return "Sort matches based on the healing done by this player in a match";
      case _damageTaken:
        return "Sort matches based on the damage taken by this player in a match";
      default:
        return "";
    }
  }

  static String? getSortTextChipValue({
    required CombinedMatch combinedMatch,
    required String sort,
  }) {
    final matchPlayer = combinedMatch.matchPlayers.first;
    final playerStats = matchPlayer.playerStats;

    switch (sort) {
      case _date:
        return null;
      case _kills:
        return "Kills ${playerStats.kills}";
      case _deaths:
        return "Deaths ${playerStats.deaths}";
      case _damage:
        return null;
      case _healing:
        return null;
      case _damageTaken:
        return "Taken ${playerStats.totalDamageTaken}";
      default:
        return "";
    }
  }

  static List<CombinedMatch> clearSorting(
    List<CombinedMatch> combinedMatches,
  ) =>
      _sortByDate(combinedMatches);

  static List<CombinedMatch> _sortByDate(
    List<CombinedMatch> combinedMatches,
  ) =>
      combinedMatches
          .sortedWith(
            (a, b) => b.match.matchId.compareTo(a.match.matchId),
          )
          .toList();

  static List<CombinedMatch> _sortByKills(
    List<CombinedMatch> combinedMatches,
  ) =>
      combinedMatches
          .sortedWith(
            (a, b) => b.matchPlayers.first.playerStats.kills.compareTo(
              a.matchPlayers.first.playerStats.kills,
            ),
          )
          .toList();

  static List<CombinedMatch> _sortByDeaths(
    List<CombinedMatch> combinedMatches,
  ) =>
      combinedMatches
          .sortedWith(
            (a, b) => b.matchPlayers.first.playerStats.deaths.compareTo(
              a.matchPlayers.first.playerStats.deaths,
            ),
          )
          .toList();

  static List<CombinedMatch> _sortByDamage(
    List<CombinedMatch> combinedMatches,
  ) =>
      combinedMatches
          .sortedWith(
            (a, b) =>
                b.matchPlayers.first.playerStats.totalDamageDealt.compareTo(
              a.matchPlayers.first.playerStats.totalDamageDealt,
            ),
          )
          .toList();

  static List<CombinedMatch> _sortByHealing(
    List<CombinedMatch> combinedMatches,
  ) =>
      combinedMatches
          .sortedWith(
            (a, b) => b.matchPlayers.first.playerStats.healingDone.compareTo(
              a.matchPlayers.first.playerStats.healingDone,
            ),
          )
          .toList();

  static List<CombinedMatch> _sortByDamageTaken(
    List<CombinedMatch> combinedMatches,
  ) =>
      combinedMatches
          .sortedWith(
            (a, b) =>
                b.matchPlayers.first.playerStats.totalDamageTaken.compareTo(
              a.matchPlayers.first.playerStats.totalDamageTaken,
            ),
          )
          .toList();
}
