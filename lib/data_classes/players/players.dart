import 'package:paladinsedge/models/index.dart' as models;

class LoadoutItem {
  final models.Card? card;
  final int cardLevel;

  LoadoutItem({
    required this.card,
    required this.cardLevel,
  });
}
