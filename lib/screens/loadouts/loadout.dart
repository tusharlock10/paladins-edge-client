import 'package:flutter/material.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class Loadout extends StatelessWidget {
  final models.Loadout loadout;
  final models.Champion champion;
  const Loadout({
    required this.loadout,
    required this.champion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      clipBehavior: Clip.hardEdge,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 72,
                  ),
                  Text(
                    loadout.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 72,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: loadout.isImported
                          ? const Text(
                              'In Game',
                              style: TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: Colors.green,
                              ),
                            )
                          : const SizedBox(
                              width: 72,
                            ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              LayoutBuilder(
                builder: (context, constraints) {
                  final imageWidth = constraints.maxWidth / 5;
                  final imageHeight =
                      imageWidth / constants.ImageAspectRatios.loadoutCard;

                  return Row(
                    children: loadout.loadoutCards.map(
                      (loadoutCard) {
                        final card = champion.cards.firstWhere(
                          (_) => _.cardId2 == loadoutCard.cardId2,
                        );

                        return widgets.LoadoutDeckCard(
                          imageHeight: imageHeight,
                          imageWidth: imageWidth,
                          card: card,
                          champion: champion,
                          loadoutCard: loadoutCard,
                          sliderFixed: true,
                        );
                      },
                    ).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
