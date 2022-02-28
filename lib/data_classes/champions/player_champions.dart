class PlayerChampionsSortData {
  final String iconUrl;
  final int sortedIndex;

  PlayerChampionsSortData({
    required this.iconUrl,
    required this.sortedIndex,
  });

  int compareTo(PlayerChampionsSortData other) {
    return sortedIndex - other.sortedIndex;
  }
}
