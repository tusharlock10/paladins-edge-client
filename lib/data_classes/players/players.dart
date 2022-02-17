import 'package:paladinsedge/models/index.dart' as models;

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
