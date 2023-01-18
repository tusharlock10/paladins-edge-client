import "dart:math";

import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/widgets/index.dart" as widgets;

class CreateLoadoutDraggableCards extends ConsumerWidget {
  final models.Champion champion;
  const CreateLoadoutDraggableCards({
    required this.champion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final draftLoadout = ref.watch(
      providers.loadout.select((_) => _.draftLoadout),
    );

    // Variables
    final width = MediaQuery.of(context).size.width;
    final imageWidth = min(width * 0.4, 156).toDouble();
    final imageHeight = (imageWidth / constants.ImageAspectRatios.championCard);
    final cardHeight = 80 + imageHeight;
    final usedCards = draftLoadout.loadoutCards.map((_) => _?.cardId2);

    if (champion.cards.isEmpty) {
      return const SizedBox();
    }

    return SizedBox(
      height: cardHeight + 10,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: champion.cards.length,
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        itemBuilder: (context, index) {
          final card = champion.cards[index];

          if (usedCards.contains(card.cardId2)) {
            return widgets.ChampionLoadoutCard(
              imageWidth: imageWidth,
              imageHeight: imageHeight,
            );
          }

          return Draggable<models.ChampionCard>(
            data: card,
            affinity: Axis.vertical,
            maxSimultaneousDrags: 1,
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
