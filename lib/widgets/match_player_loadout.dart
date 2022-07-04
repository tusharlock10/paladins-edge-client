import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/fast_image.dart";
import "package:paladinsedge/widgets/loadout_card_detail.dart";

class MatchPlayerLoadout extends StatelessWidget {
  final models.Champion champion;
  final models.MatchPlayer matchPlayer;
  final double size;

  const MatchPlayerLoadout({
    required this.champion,
    required this.matchPlayer,
    this.size = 32,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: utilities.insertBetween(
        matchPlayer.playerChampionCards.map(
          (playerChampionCard) {
            final card = champion.cards.firstOrNullWhere(
              (_) => _.cardId2 == playerChampionCard.cardId2,
            );

            if (card == null) {
              return const SizedBox();
            }

            return GestureDetector(
              onTap: () => showLoadoutCardDetailSheet(
                data_classes.ShowLoadoutDetailsOptions(
                  context: context,
                  champion: champion,
                  card: card,
                  cardPoints: playerChampionCard.cardLevel,
                  sliderFixed: true,
                ),
              ),
              child: FastImage(
                imageUrl: utilities.getSmallAsset(card.imageUrl),
                imageBlurHash: card.imageBlurHash,
                width: size,
                height: size / constants.ImageAspectRatios.championCard,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            );
          },
        ).toList(),
        const SizedBox(width: 5),
      ),
    );
  }
}
