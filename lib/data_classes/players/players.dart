import "package:paladinsedge/models/index.dart" as models;

class LoadoutItem {
  final models.Card? card;
  final int cardLevel;

  const LoadoutItem({
    required this.card,
    required this.cardLevel,
  });
}

class StatLabelGridProps {
  double itemHeight;
  double itemWidth;
  int crossAxisCount;

  StatLabelGridProps({
    required this.itemHeight,
    required this.itemWidth,
    required this.crossAxisCount,
  });
}

class RecentWinStats {
  final int normalMatches;
  final int normalWins;
  final int rankedMatches;
  final int rankedWins;

  const RecentWinStats({
    this.normalMatches = 0,
    this.normalWins = 0,
    this.rankedMatches = 0,
    this.rankedWins = 0,
  });
}
