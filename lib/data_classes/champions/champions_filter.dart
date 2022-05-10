import 'package:paladinsedge/data_classes/champions/combined_champion.dart';

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
  static const _damageType = "Damage Type";
  static const _role = "Role";
  static const _freeRotation = "Free Rotation";

  static List<String> get filterNames => [_role, _damageType, _freeRotation];

  static List<String>? getFilterValues(
    String filter,
  ) {
    switch (filter) {
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
      case _role:
        return "Filter champions by their role in the game";
      case _damageType:
        return "Filter champions by their type of damage";
      case _freeRotation:
        return "Filter champions that are in free rotation";
      default:
        return '';
    }
  }

  static List<CombinedChampion> getFilteredChampions({
    required List<CombinedChampion> combinedChampions,
    required SelectedChampionsFilter filter,
  }) {
    switch (filter.name) {
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
            (combinedChampion) => combinedChampion.copyWith(hide: false),
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

    return combinedChampions
        .map(
          (combinedChampion) => combinedChampion.copyWith(
            hide: !(combinedChampion.champion.name
                    .toLowerCase()
                    .contains(search) ||
                combinedChampion.champion.title.toLowerCase().contains(search)),
          ),
        )
        .toList();
  }

  static List<CombinedChampion> _filterByRole(
    List<CombinedChampion> combinedChampions,
    SelectedChampionsFilter filter,
  ) =>
      combinedChampions
          .map(
            (combinedChampion) => combinedChampion.copyWith(
              hide: combinedChampion.champion.role != filter.value,
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
            ),
          )
          .toList();
}
