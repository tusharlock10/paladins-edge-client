import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

void showLoadoutCardDetailSheet({
  required BuildContext context,
  required models.Champion champion,
  required models.Card card,
  int? cardPoints,
}) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    context: context,
    builder: (_) {
      return _LoadoutCardDetail(
        card: card,
        champion: champion,
        cardPoints: cardPoints,
      );
    },
  );
}

class _LoadoutCardDetail extends HookWidget {
  final models.Card card;
  final models.Champion champion;
  final int? cardPoints;

  const _LoadoutCardDetail({
    required this.card,
    required this.champion,
    this.cardPoints,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;

    // State
    final amount = useState(cardPoints ?? 1);

    // Methods
    final getDescriptionParts =
        useCallback(() => utilities.getDescriptionParts(card.description), []);

    final getParsedDescription = useCallback(
      () => utilities.getParsedDescription(getDescriptionParts(), amount.value),
      [amount.value],
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          elevation: 10,
          shadowColor: theme.darkThemeMaterialColor.shade100.withOpacity(0.6),
          clipBehavior: Clip.hardEdge,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widgets.ElevatedAvatar(
                  imageUrl: card.imageUrl,
                  size: 36,
                  fit: BoxFit.cover,
                  borderRadius: 10,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        champion.name.toUpperCase(),
                        style: textTheme.bodyText1?.copyWith(fontSize: 12),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        card.name.toUpperCase(),
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                        style: textTheme.headline1?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 2),
                      Wrap(
                        direction: Axis.horizontal,
                        children: [
                          widgets.TextChip(
                            hidden: card.cooldown == 0,
                            spacing: 5,
                            text: '${card.cooldown.toInt().toString()} sec',
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Text(
                getParsedDescription(),
                textAlign: TextAlign.center,
                style: textTheme.bodyText2?.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 10),
              AbsorbPointer(
                absorbing: cardPoints != null,
                child: Slider(
                  value: amount.value.toDouble(),
                  divisions: 4,
                  min: 1,
                  max: 5,
                  label: '${amount.value}',
                  onChanged: (value) => amount.value = value.toInt(),
                ),
              ),
              cardPoints != null
                  ? const SizedBox()
                  : const SizedBox(height: 10),
              cardPoints != null
                  ? const SizedBox()
                  : Text(
                      '*Change slider to view the card with different points',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyText1?.copyWith(fontSize: 12),
                    ),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}