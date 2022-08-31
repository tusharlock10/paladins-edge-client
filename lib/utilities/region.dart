import "package:paladinsedge/data_classes/index.dart" as data_classes;

/// Takes a region in a random string format and provides the appropriate formatted region
String? sanitizeRegion(String region) {
  region = region.toLowerCase();

  if (region.contains("eu")) return data_classes.Region.europe;
  if (region.contains("sea") || region.contains("asia")) {
    return data_classes.Region.southEastAsia;
  }
  if (region.contains("br")) return data_classes.Region.brazil;
  if (region.contains("aus") || region.contains("oce")) {
    return data_classes.Region.oceania;
  }
  if (region.contains("latin")) return data_classes.Region.latinAmerica;
  if (region.contains("jp") || region.contains("japan")) {
    return data_classes.Region.japan;
  }
  if (region.contains("na") || region.contains("north")) {
    return data_classes.Region.northAmerica;
  }

  return null;
}
