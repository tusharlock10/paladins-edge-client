import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class LoadoutDeckCard extends HookWidget {
  final double imageHeight;
  final double imageWidth;
  final models.Card card;
  final models.Champion champion;
  final models.LoadoutCard loadoutCard;
  final bool sliderFixed;
  final void Function(int)? onSliderChange;

  const LoadoutDeckCard({
    required this.imageHeight,
    required this.imageWidth,
    required this.card,
    required this.champion,
    required this.loadoutCard,
    required this.sliderFixed,
    this.onSliderChange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Methods
    final onTapCard = useCallback(
      () {
        utilities.unFocusKeyboard(context);
        widgets.showLoadoutCardDetailSheet(
          data_classes.ShowLoadoutDetailsOptions(
            context: context,
            champion: champion,
            card: card,
            cardPoints: loadoutCard.level,
            onSliderChange: onSliderChange,
            sliderFixed: sliderFixed,
          ),
        );
      },
      [],
    );

    return SizedBox(
      height: imageHeight,
      width: imageWidth,
      child: Card(
        margin: const EdgeInsets.all(4),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          child: GestureDetector(
            onTap: onTapCard,
            child: Stack(
              children: [
                SizedBox(
                  height: imageHeight,
                  child: widgets.FastImage(
                    fit: BoxFit.cover,
                    imageUrl: card.imageUrl,
                  ),
                ),
                loadoutCard.level == 0
                    ? const SizedBox()
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: imageWidth,
                          height: imageHeight * 0.25,
                          color: theme.darkThemeMaterialColor.shade200
                              .withOpacity(0.4),
                          child: Center(
                            child: Text(
                              loadoutCard.level.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
