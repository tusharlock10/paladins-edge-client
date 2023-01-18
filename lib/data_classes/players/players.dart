import "package:paladinsedge/models/index.dart" as models;

class LoadoutItem {
  final models.ChampionCard? card;
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
    required this.normalMatches,
    required this.normalWins,
    required this.rankedMatches,
    required this.rankedWins,
  });
}
