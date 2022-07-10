class PlayerChampionsSortData {
  final int championId;
  final String iconUrl;
  final int sortedIndex;
  final String name;
  final String? iconBlurHash;

  PlayerChampionsSortData({
    required this.championId,
    required this.iconUrl,
    required this.sortedIndex,
    required this.name,
    this.iconBlurHash,
  });

  int compareTo(PlayerChampionsSortData other) {
    return name.compareTo(other.name);
  }
}
