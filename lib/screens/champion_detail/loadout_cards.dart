import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class LoadoutCards extends HookWidget {
  const LoadoutCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final champion =
        ModalRoute.of(context)?.settings.arguments as models.Champion;
    final textTheme = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;
    final cardWidth = min(width * 0.4, 156).toDouble();
    final imageWidth = cardWidth - 10;
    final imageHeight = (imageWidth / constants.ImageAspectRatios.championCard);
    final cardHeight = 80 + imageHeight;

    if (champion.cards == null) {
      return const SizedBox();
    }

    return SizedBox(
      height: cardHeight + 10,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        }),
        child: NotificationListener<ScrollNotification>(
          onNotification: (_) => true,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: champion.cards.length,
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            itemBuilder: (context, index) {
              final card = champion.cards[index];

              return SizedBox(
                width: cardWidth,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    margin: const EdgeInsets.all(0),
                    clipBehavior: Clip.hardEdge,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: InkWell(
                      onTap: () => widgets.showLoadoutCardDetailSheet(
                        card: card,
                        champion: champion,
                        context: context,
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: widgets.FastImage(
                              imageUrl: card.imageUrl,
                              width: imageWidth,
                              height: imageHeight,
                            ),
                          ),
                          SizedBox(
                            height: 70,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Text(
                                    card.name,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.bodyText2?.copyWith(
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        widgets.TextChip(
                                          hidden: card.cooldown == 0,
                                          spacing: 5,
                                          text:
                                              '${card.cooldown.toInt().toString()} sec',
                                          color: Colors.blueGrey,
                                          icon: Icons.timelapse,
                                        ),
                                        widgets.TextChip(
                                          hidden: card.modifier == "None",
                                          spacing: 5,
                                          text: card.modifier,
                                          color: Colors.teal,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
