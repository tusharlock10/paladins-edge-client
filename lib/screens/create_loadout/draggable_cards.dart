import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class DraggableCards extends HookWidget {
  const DraggableCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final champion =
        ModalRoute.of(context)?.settings.arguments as models.Champion;
    final width = MediaQuery.of(context).size.width;
    final imageWidth = min(width * 0.4, 156).toDouble();
    final imageHeight = (imageWidth / constants.ImageAspectRatios.championCard);
    final cardHeight = 80 + imageHeight;

    // State
    final usedCards = useState<List<String>>([]);

    if (champion.cards.isEmpty) {
      return const SizedBox();
    }

    // Methods
    final onDragCard = useCallback(
      (models.Card card) {
        usedCards.value = List.from(usedCards.value)
          ..add(card.cardId.toString());
      },
      [],
    );

    return SizedBox(
      height: cardHeight + 10,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: champion.cards.length,
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        itemBuilder: (context, index) {
          final card = champion.cards[index];

          if (usedCards.value.contains(card.cardId.toString())) {
            return widgets.ChampionLoadoutCard(
              imageWidth: imageWidth,
              imageHeight: imageHeight,
            );
          }

          return Draggable<models.Card>(
            affinity: Axis.vertical,
            data: card,
            onDragCompleted: () => onDragCard(card),
            feedback: widgets.ChampionLoadoutCard(
              card: card,
              champion: champion,
              imageWidth: imageWidth,
              imageHeight: imageHeight,
              onPress: () => {},
            ),
            childWhenDragging: widgets.ChampionLoadoutCard(
              imageWidth: imageWidth,
              imageHeight: imageHeight,
            ),
            child: widgets.ChampionLoadoutCard(
              card: card,
              champion: champion,
              imageWidth: imageWidth,
              imageHeight: imageHeight,
            ),
          );
        },
      ),
    );
  }
}
