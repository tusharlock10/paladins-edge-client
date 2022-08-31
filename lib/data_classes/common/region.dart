import "package:dartx/dartx.dart";

abstract class Region {
  static const northAmerica = "NA";
  static const europe = "EU";
  static const brazil = "BR";
  static const japan = "JP";
  static const southEastAsia = "SEA";
  static const latinAmerica = "LA";
  static const oceania = "OCE";
  static const all = "ALL";

  static const defaultRegion = all;

  static const allRegions = [
    northAmerica,
    europe,
    brazil,
    japan,
    southEastAsia,
    latinAmerica,
    oceania,
    all,
  ];

  static String getFullName(String region) {
    switch (region) {
      case northAmerica:
        return "North America";
      case europe:
        return "Europe";
      case brazil:
        return "Brazil";
      case japan:
        return "Japan";
      case southEastAsia:
        return "South East Asia";
      case latinAmerica:
        return "Latin America";
      case oceania:
        return "Oceania";
    }

    return "All Regions";
  }

  /// Get the next region in line when a region is provided
  static String cycleRegions(String region) {
    final index = allRegions.indexWhere((queueRegion) => queueRegion == region);

    return allRegions.elementAtOrDefault(index + 1, allRegions.first);
  }
}
