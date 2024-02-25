import "package:paladinsedge/data_classes/champions/combined_champion.dart";
import "package:paladinsedge/models/index.dart" as models;

class SelectedChampionsFilter {
  final String? name;
  final String? value;

  bool get isValid {
    return value != null && name != null;
  }

  SelectedChampionsFilter({
    this.name,
    this.value,
  });
}

abstract class ChampionsFilter {
  static const _favourite = "Favourites";
  static const _damageType = "Damage Type";
  static const _role = "Role";
  static const _freeRotation = "Free Rotation";

  static List<String> filterNames(bool isGuest) => [
        if (!isGuest) _favourite,
        _role,
        _damageType,
        _freeRotation,
      ];

  static List<String>? getFilterValues(
    String filter,
  ) {
    switch (filter) {
      case _favourite:
        return [true.toString(), false.toString()];
      case _role:
        return ["Damage", "Flank", "Support", "Tank"];
      case _damageType:
        return ["Area Damage", "Direct Damage"];
      case _freeRotation:
        return [true.toString(), false.toString()];
      default:
        return null;
    }
  }

  static String getFilterDescription(
    String filter,
  ) {
    switch (filter) {
      case _favourite:
        return "Filter champions based on they are your favourite";
      case _role:
        return "Filter champions by their role in the game";
      case _damageType:
        return "Filter champions by their type of damage";
      case _freeRotation:
        return "Filter champions that are in free rotation";
      default:
        return "";
    }
  }

  static List<CombinedChampion> getFilteredChampions({
    required List<CombinedChampion> combinedChampions,
    required SelectedChampionsFilter filter,
    required Set<int> favouriteChampions,
  }) {
    switch (filter.name) {
      case _favourite:
        return _filterByFavourite(
          combinedChampions,
          filter,
          favouriteChampions,
        );
      case _role:
        return _filterByRole(combinedChampions, filter);
      case _damageType:
        return _filterByDamageType(combinedChampions, filter);
      case _freeRotation:
        return _filterByFreeRotation(combinedChampions, filter);
      default:
        return combinedChampions;
    }
  }

  static List<CombinedChampion> clearFilters(
    List<CombinedChampion> combinedChampions,
  ) =>
      combinedChampions
          .map(
            (combinedChampion) => combinedChampion.copyWith(
              hide: false,
              searchCondition: null,
            ),
          )
          .toList();

  static List<CombinedChampion> filterBySearch(
    List<CombinedChampion> combinedChampions,
    String search,
  ) {
    // Filter champions by searching their name
    // if a champion is already hidden due to other filters,
    // those filters should be removed
    search = search.toLowerCase().trim();
    List<CombinedChampion> result = combinedChampions;

    for (final searchCondition in ChampionsSearchCondition.values) {
      bool isValidResult = false;

      result = combinedChampions.map(
        (combinedChampion) {
          final canShowChampion = _filterBySearchCondition(
            search,
            combinedChampion,
            searchCondition,
          );

          // set isValidResult to true if we can show a champion
          if (!isValidResult) isValidResult = canShowChampion;

          return combinedChampion.copyWith(
            hide: !canShowChampion,
            searchCondition: searchCondition,
          );
        },
      ).toList();
      if (isValidResult) return result.toList();
    }

    return result.toList();
  }

  static bool _talentsContainSearchValue(
    List<models.Talent> talents,
    String search,
  ) {
    for (final talent in talents) {
      if (talent.name.toLowerCase().contains(search)) return true;
    }

    return false;
  }

  static bool _filterBySearchCondition(
    String search,
    CombinedChampion combinedChampion,
    ChampionsSearchCondition searchCondition,
  ) {
    final playerChampion = combinedChampion.playerChampion;
    final champion = combinedChampion.champion;

    if (searchCondition == ChampionsSearchCondition.name &&
        champion.name.toLowerCase().contains(search)) return true;
    if (searchCondition == ChampionsSearchCondition.championId &&
        champion.championId.toString().contains(search)) return true;
    if (searchCondition == ChampionsSearchCondition.title &&
        champion.title.toLowerCase().contains(search)) return true;
    if (searchCondition == ChampionsSearchCondition.role &&
        champion.role.toLowerCase().contains(search)) return true;
    if (searchCondition == ChampionsSearchCondition.level &&
        "level ${playerChampion?.level}".contains(search)) return true;
    if (searchCondition == ChampionsSearchCondition.talent &&
        _talentsContainSearchValue(champion.talents, search)) return true;

    return false;
  }

  static List<CombinedChampion> _filterByFavourite(
    List<CombinedChampion> combinedChampions,
    SelectedChampionsFilter filter,
    Set<int> favouriteChampions,
  ) =>
      combinedChampions
          .map(
            (combinedChampion) => combinedChampion.copyWith(
              hide: favouriteChampions
                      .contains(combinedChampion.champion.championId)
                      .toString() !=
                  filter.value,
              searchCondition: null,
            ),
          )
          .toList();

  static List<CombinedChampion> _filterByRole(
    List<CombinedChampion> combinedChampions,
    SelectedChampionsFilter filter,
  ) =>
      combinedChampions
          .map(
            (combinedChampion) => combinedChampion.copyWith(
              hide: combinedChampion.champion.role != filter.value,
              searchCondition: null,
            ),
          )
          .toList();

  static List<CombinedChampion> _filterByFreeRotation(
    List<CombinedChampion> combinedChampions,
    SelectedChampionsFilter filter,
  ) =>
      combinedChampions
          .map(
            (combinedChampion) => combinedChampion.copyWith(
              hide: combinedChampion.champion.onFreeRotation.toString() !=
                  filter.value,
              searchCondition: null,
            ),
          )
          .toList();

  static List<CombinedChampion> _filterByDamageType(
    List<CombinedChampion> combinedChampions,
    SelectedChampionsFilter filter,
  ) =>
      // Takes the first ability of the champion
      // This ability will be the primary fire
      combinedChampions
          .map(
            (combinedChampion) => combinedChampion.copyWith(
              hide: combinedChampion.champion.abilities.first.damageType !=
                  filter.value,
              searchCondition: null,
            ),
          )
          .toList();
}
