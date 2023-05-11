import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

void showLoadoutCardDetailSheet(
  data_classes.ShowLoadoutDetailsOptions options,
) {
  final context = options.context;
  final screenWidth = MediaQuery.of(context).size.width;
  final width = utilities.responsiveCondition(
    context,
    desktop: screenWidth / 2.5,
    tablet: screenWidth / 1.5,
    mobile: screenWidth,
  );

  HapticFeedback.mediumImpact();
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
        card: options.card,
        champion: options.champion,
        cardPoints: options.cardPoints,
        onSliderChange: options.onSliderChange,
        sliderFixed: options.sliderFixed,
      );
    },
    constraints: BoxConstraints(maxWidth: width),
  );
}

class _LoadoutCardDetail extends HookWidget {
  final models.ChampionCard card;
  final models.Champion champion;
  final bool sliderFixed;
  final int cardPoints;
  final void Function(int)? onSliderChange;

  const _LoadoutCardDetail({
    required this.card,
    required this.champion,
    required this.sliderFixed,
    required this.cardPoints,
    this.onSliderChange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;

    // State
    final amount = useState(cardPoints);

    // Methods
    final getDescriptionParts =
        useCallback(() => utilities.getDescriptionParts(card.description), []);

    final getParsedDescription = useCallback(
      () => utilities.getParsedDescription(getDescriptionParts(), amount.value),
      [amount.value],
    );

    final onChangedWithHaptic = useCallback(
      (double value) {
        amount.value = value.toInt();
        HapticFeedback.lightImpact();
        if (onSliderChange != null) {
          onSliderChange!(amount.value);
        }
      },
      [],
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
                  imageBlurHash: card.imageBlurHash,
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
                      SelectableText(
                        champion.name.toUpperCase(),
                        style: textTheme.bodyLarge?.copyWith(fontSize: 12),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        card.name.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.displayLarge?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 2),
                      Wrap(
                        direction: Axis.horizontal,
                        children: [
                          if (card.cooldown != 0)
                            widgets.TextChip(
                              spacing: 5,
                              text: "${card.cooldown.toInt()} sec",
                              color: Colors.blueGrey,
                              icon: Icons.timelapse,
                            ),
                          if (card.modifier != "None")
                            widgets.TextChip(
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
              SelectableText(
                getParsedDescription(),
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 10),
              AbsorbPointer(
                absorbing: sliderFixed,
                child: Slider(
                  value: amount.value.toDouble(),
                  divisions: 4,
                  min: 1,
                  max: 5,
                  label: "${amount.value}",
                  onChanged: onChangedWithHaptic,
                ),
              ),
              sliderFixed ? const SizedBox() : const SizedBox(height: 10),
              sliderFixed
                  ? const SizedBox()
                  : Text(
                      "*Change slider to view the card with different points",
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge?.copyWith(fontSize: 12),
                    ),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
