import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class CreateLoadoutTarget extends HookConsumerWidget {
  const CreateLoadoutTarget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final loadoutProvider = ref.read(providers.loadout);
    final draftLoadout =
        ref.watch(providers.loadout.select((_) => _.draftLoadout));

    // Variables
    final arguments = ModalRoute.of(context)?.settings.arguments
        as data_classes.CreateLoadoutScreenArguments;
    final champion = arguments.champion;

    // State
    final loadoutNameError = useState(false);

    // Hooks
    final loadoutNameController =
        useTextEditingController(text: draftLoadout.name);

    // Methods
    final getLoadoutPoints = useCallback(
      () {
        int points = 0;
        Color color = Colors.orange;

        for (var _ in draftLoadout.loadoutCards) {
          points += _?.level ?? 0;
        }

        if (points == 15) color = Colors.green;
        if (points > 15) color = Colors.red;

        return {
          'points': points,
          'color': color,
        };
      },
      [draftLoadout],
    );

    final onChangeLoadoutName = useCallback(
      (String name) =>
          loadoutNameError.value = loadoutProvider.onChangeLoadoutName(name),
      [],
    );

    final loadoutPoints = getLoadoutPoints();

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
                  SizedBox(
                    width: 72,
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          const TextSpan(text: '('),
                          TextSpan(
                            text: loadoutPoints['points'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: loadoutPoints['color'] as Color,
                            ),
                          ),
                          const TextSpan(text: '/15)'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.name,
                      autocorrect: false,
                      controller: loadoutNameController,
                      decoration: InputDecoration(
                        counterText: '',
                        errorText: loadoutNameError.value
                            ? 'Please enter a loadout name'
                            : null,
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      enableSuggestions: false,
                      maxLength: 25,
                      onChanged: onChangeLoadoutName,
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

                        return DragTarget<models.Card>(
                          onWillAccept: (_) => true,
                          onAccept: (card) =>
                              loadoutProvider.onAcceptDragCard(card, index),
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

                            final _index = champion.cards.indexWhere(
                              (_) => _.cardId2 == loadoutCard?.cardId2,
                            );

                            if (_index != -1) {
                              final _card = champion.cards[_index];

                              return widgets.LoadoutDeckCard(
                                imageHeight: imageHeight,
                                imageWidth: imageWidth,
                                card: _card,
                                champion: champion,
                                loadoutCard: loadoutCard!,
                                sliderFixed: false,
                                onSliderChange: (cardPoints) => loadoutProvider
                                    .onSliderChange(loadoutCard, cardPoints),
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