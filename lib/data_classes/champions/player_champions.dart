class PlayerChampionsSortData {
  final String iconUrl;
  final int sortedIndex;
  final String? iconBlurHash;

  PlayerChampionsSortData({
    required this.iconUrl,
    required this.sortedIndex,
    this.iconBlurHash,
  });

  int compareTo(PlayerChampionsSortData other) {
    return sortedIndex - other.sortedIndex;
  }
}
