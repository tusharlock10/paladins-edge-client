abstract class TopMatchTypes {
  static const longMatch = "longMatch";
  static const healing = "healing";
  static const kills = "kills";
  static const damage = "damage";

  static String getMatchTypeName(String topMatchType) {
    switch (topMatchType) {
      case longMatch:
        return "Minutes";
      case healing:
        return "Heals";
      case damage:
        return "Damage";
      case kills:
        return "Kills";
      default:
        return "";
    }
  }
}
