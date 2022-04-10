import 'package:dartx/dartx.dart';
import 'package:paladinsedge/models/index.dart' as models;

abstract class ChampionsSort {
  static const _name = "Name";
  static const _level = "Level";
  static const _health = "Health";
  static const _winRate = "Win Rate";
  static const _releasedDate = "B'day";
  static const _dps = "DPS";
  static const _lastPlayed = "Last Played";

  static String get defaultSort => _name;

  static List<String> get championSorts =>
      [_name, _health, _releasedDate, _dps];

  static List<String> get playerChampionSorts => [
        _level,
        _winRate,
        _lastPlayed,
      ];

  static List<models.Champion> getSortedChampions({
    required List<models.Champion> champions,
    required String sort,
  }) {
    switch (sort) {
      case _name:
        return _sortByName(champions);
      case _health:
        return _sortByHealth(champions);
      case _releasedDate:
        return _sortByReleaseDate(champions);
      case _dps:
        return _sortByDPS(champions);
      default:
        return champions;
    }
  }

  static List<models.PlayerChampion> getSortedPlayerChampions({
    required List<models.PlayerChampion> playerChampions,
    required String sort,
  }) {
    switch (sort) {
      case _level:
        return _sortByLevel(playerChampions);
      case _winRate:
        return _sortByWinRate(playerChampions);
      case _lastPlayed:
        return _sortByLastPlayed(playerChampions);
      default:
        return playerChampions;
    }
  }

  static List<models.Champion> _sortByName(List<models.Champion> champions) =>
      champions.sortedWith((a, b) => a.name.compareTo(b.name)).toList();

  static List<models.Champion> _sortByHealth(List<models.Champion> champions) =>
      champions.sortedWith((a, b) => a.health.compareTo(b.health)).toList();

  static List<models.Champion> _sortByReleaseDate(
    List<models.Champion> champions,
  ) =>
      champions
          .sortedWith((a, b) => a.releaseDate.compareTo(b.releaseDate))
          .toList();

  static List<models.Champion> _sortByDPS(List<models.Champion> champions) =>
      champions.sortedWith((a, b) {
        final aDPS = a.weaponDamage / a.fireRate;
        final bDPS = b.weaponDamage / b.fireRate;

        return aDPS.compareTo(bDPS);
      }).toList();

  static List<models.PlayerChampion> _sortByLevel(
    List<models.PlayerChampion> playerChampions,
  ) =>
      playerChampions.sortedWith((a, b) => a.level.compareTo(b.level)).toList();

  static List<models.PlayerChampion> _sortByWinRate(
    List<models.PlayerChampion> playerChampions,
  ) =>
      playerChampions.sortedWith((a, b) {
        final aWinRate = a.wins / a.losses;
        final bWinRate = b.wins / b.losses;

        return bWinRate.compareTo(aWinRate);
      }).toList();

  static List<models.PlayerChampion> _sortByLastPlayed(
    List<models.PlayerChampion> playerChampions,
  ) =>
      playerChampions
          .sortedWith((a, b) => a.lastPlayed.compareTo(b.lastPlayed))
          .toList();
}
