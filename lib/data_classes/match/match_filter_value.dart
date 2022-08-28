import "package:jiffy/jiffy.dart";

enum MatchFilterValueType { normal, dates }

class MatchFilterValue {
  final String value;
  final Map<String, DateTime?> dateValue;
  final MatchFilterValueType type;
  final String _valueName;

  String get valueName =>
      type == MatchFilterValueType.dates ? _getDateValueName() : _valueName;

  const MatchFilterValue({
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

abstract class MatchFilterValues {
  static const map = [
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
    MatchFilterValue(valueName: "ONS: MP", value: "Marauder's Port"),
    MatchFilterValue(valueName: "ONS: FR", value: "Foreman's Rise"),
    MatchFilterValue(valueName: "ONS: PC", value: "Primal Court"),
    MatchFilterValue(
      valueName: "ONS: MA",
      value: "Magistrate's Archives",
    ),
  ];

  static const betweenDates = [
    MatchFilterValue(
      value: "Select Dates",
      valueName: "Select Dates",
      type: MatchFilterValueType.dates,
    ),
  ];

  static const queue = [
    MatchFilterValue(value: "Casual Siege", valueName: "SG"),
    MatchFilterValue(value: "Team Deathmatch ", valueName: "TDM"),
    MatchFilterValue(value: "Onslaught", valueName: "ONS"),
    MatchFilterValue(value: "Ranked Keyboard", valueName: "RNK: KBM"),
    MatchFilterValue(value: "Ranked Controller ", valueName: "RNK: CON"),
    MatchFilterValue(value: "Other", valueName: "Other"),
  ];

  static const roles = [
    MatchFilterValue(value: "Damage", valueName: "Damage"),
    MatchFilterValue(value: "Flank", valueName: "Flank"),
    MatchFilterValue(value: "Support", valueName: "Support"),
    MatchFilterValue(value: "Tank", valueName: "Tank"),
  ];
}
