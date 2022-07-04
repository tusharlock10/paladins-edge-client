import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/widgets/index.dart" as widgets;

class LoadoutItem extends StatelessWidget {
  static const loadoutAspectRatio = 33 / 18;

  final models.Loadout loadout;
  final models.Champion champion;
  const LoadoutItem({
    required this.loadout,
    required this.champion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final loadoutWidth = constraints.maxWidth;
        final loadoutHeight = loadoutWidth / loadoutAspectRatio;

        final imageWidth = (loadoutWidth - 24) / 5;
        final imageHeight =
            imageWidth / constants.ImageAspectRatios.loadoutCard;

        return SizedBox(
          height: loadoutHeight,
          width: loadoutWidth,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            clipBehavior: Clip.hardEdge,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              loadout.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: loadout.isImported
                                  ? const widgets.TextChip(
                                      text: "In Game",
                                      color: Colors.green,
                                      width: 72,
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.only(left: 16),
                                      child: widgets.TextChip(
                                        text: "Edit",
                                        color: Colors.blueGrey,
                                        trailingIcon: FeatherIcons.chevronRight,
                                        width: 56,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: loadout.loadoutCards.map(
                        (loadoutCard) {
                          final card = champion.cards.firstOrNullWhere(
                            (_) => _.cardId2 == loadoutCard.cardId2,
                          );

                          if (card == null) {
                            return const SizedBox();
                          }

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
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
