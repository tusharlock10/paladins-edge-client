import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class DraggableCards extends HookConsumerWidget {
  const DraggableCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final draftLoadout =
        ref.watch(providers.loadout.select((_) => _.draftLoadout));

    // Variables
    final arguments = ModalRoute.of(context)?.settings.arguments
        as data_classes.CreateLoadoutScreenArguments;
    final champion = arguments.champion;
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
        physics: const BouncingScrollPhysics(),
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

          return Draggable<models.Card>(
            affinity: Axis.vertical,
            data: card,
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
