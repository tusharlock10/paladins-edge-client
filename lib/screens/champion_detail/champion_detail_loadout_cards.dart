import "dart:math";

import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:paladinsedge/constants.dart" as constants;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/widgets/index.dart" as widgets;

class ChampionDetailLoadoutCards extends HookWidget {
  final models.Champion champion;
  const ChampionDetailLoadoutCards({
    required this.champion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final width = MediaQuery.of(context).size.width;
    final imageWidth = min(width * 0.4, 156).toDouble();
    final imageHeight = (imageWidth / constants.ImageAspectRatios.championCard);
    final cardHeight = 80 + imageHeight;

    if (champion.cards.isEmpty) {
      return const SizedBox();
    }

    return SizedBox(
      height: cardHeight + 10,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: NotificationListener<ScrollNotification>(
          onNotification: (_) => true,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: champion.cards.length,
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            itemBuilder: (context, index) {
              final card = champion.cards[index];

              return widgets.ChampionLoadoutCard(
                card: card,
                champion: champion,
                imageWidth: imageWidth,
                imageHeight: imageHeight,
              );
            },
          ),
        ),
      ),
    );
  }
}
