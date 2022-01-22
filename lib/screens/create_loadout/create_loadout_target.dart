import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class CreateLoadoutTarget extends StatelessWidget {
  final models.DraftLoadout draftLoadout;
  final models.Champion champion;
  final bool Function(models.Card?) onWillAcceptCard;
  final void Function(models.Card, int) onAcceptDragCard;
  final void Function(models.LoadoutCard, int) onSliderChange;

  const CreateLoadoutTarget({
    required this.draftLoadout,
    required this.champion,
    required this.onWillAcceptCard,
    required this.onAcceptDragCard,
    required this.onSliderChange,
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
                    draftLoadout.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 72,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: draftLoadout.isImported
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
                    children: List.generate(
                      draftLoadout.loadoutCards.length,
                      (_) => _,
                      growable: false,
                    ).map(
                      (index) {
                        final loadoutCard = draftLoadout.loadoutCards[index];

                        if (loadoutCard == null) {
                          return DragTarget<models.Card>(
                            onWillAccept: (card) => onWillAcceptCard(card),
                            onAccept: (card) => onAcceptDragCard(card, index),
                            builder: (_, candidateData, __) {
                              final card = candidateData.isNotEmpty
                                  ? candidateData.first
                                  : null;

                              if (card != null) {
                                final loadoutCard = models.LoadoutCard(
                                  cardId2: card.cardId2,
                                  level: 0,
                                );

                                return Opacity(
                                  opacity: 0.3,
                                  child: widgets.LoadoutDeckCard(
                                    imageHeight: imageHeight,
                                    imageWidth: imageWidth,
                                    card: card,
                                    champion: champion,
                                    loadoutCard: loadoutCard,
                                    sliderFixed: false,
                                  ),
                                );
                              }

                              return Container(
                                width: imageWidth,
                                height: imageHeight,
                                padding: const EdgeInsets.all(5),
                                child: DottedBorder(
                                  child: const Center(
                                    child: Icon(Icons.add),
                                  ),
                                  strokeWidth: 1,
                                  radius: const Radius.circular(5),
                                  color: Colors.grey,
                                  borderType: BorderType.RRect,
                                ),
                              );
                            },
                          );
                        }

                        final card = champion.cards.firstWhere(
                          (_) => _.cardId2 == loadoutCard.cardId2,
                        );

                        return widgets.LoadoutDeckCard(
                          imageHeight: imageHeight,
                          imageWidth: imageWidth,
                          card: card,
                          champion: champion,
                          loadoutCard: loadoutCard,
                          sliderFixed: false,
                          onSliderChange: (cardPoints) =>
                              onSliderChange(loadoutCard, cardPoints),
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
