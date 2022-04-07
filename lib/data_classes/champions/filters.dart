import 'package:paladinsedge/models/index.dart' as models;

class ChampionsFilterValue {
  final none = null;
  final String? role;
  final String? damageType;
  final String? freeRotation;

  ChampionsFilterValue({
    this.role,
    this.damageType,
    this.freeRotation,
  });
}

abstract class ChampionsFilter {
  static const _none = "None";
  static const _damageType = "Damage Type";
  static const _role = "Role";
  static const _freeRotation = "Free Rotation";

  static String get defaultFilter => _none;

  static List<String> get filters => [_none, _role, _damageType, _freeRotation];

  static List<String>? getAllFilterValues(
    String filter,
  ) {
    switch (filter) {
      case _none:
        return null;
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

  static List<models.Champion> getFilteredChampions({
    required List<models.Champion> champions,
    required String filter,
    required ChampionsFilterValue filterValue,
  }) {
    switch (filter) {
      case _none:
        return champions;
      case _role:
        return _filterByRole(champions, filterValue);
      case _damageType:
        return _filterByDamageType(champions, filterValue);
      case _freeRotation:
        return _filterByFreeRotation(champions, filterValue);
      default:
        return champions;
    }
  }

  static List<models.Champion> _filterByRole(
    List<models.Champion> champions,
    ChampionsFilterValue filterValue,
  ) =>
      champions.where((champion) => champion.role == filterValue.role).toList();

  static List<models.Champion> _filterByFreeRotation(
    List<models.Champion> champions,
    ChampionsFilterValue filterValue,
  ) =>
      champions
          .where((champion) =>
              champion.onFreeRotation.toString() == filterValue.freeRotation)
          .toList();

  static List<models.Champion> _filterByDamageType(
    List<models.Champion> champions,
    ChampionsFilterValue filterValue,
  ) =>
      // Takes the first ability of the champion
      // This ability will be the primary fire
      champions
          .where((champion) =>
              champion.abilities.first.damageType == filterValue.damageType)
          .toList();
}
