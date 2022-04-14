import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class ChampionLoadoutCard extends HookWidget {
  final double imageWidth;
  final double imageHeight;
  final models.Card? card;
  final models.Champion? champion;
  final void Function()? onPress;

  const ChampionLoadoutCard({
    Key? key,
    required this.imageWidth,
    required this.imageHeight,
    this.card,
    this.champion,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Methods
    final openLoadoutDetail = useCallback(
      () {
        if (card == null || champion == null) return;

        utilities.unFocusKeyboard(context);
        widgets.showLoadoutCardDetailSheet(
          data_classes.ShowLoadoutDetailsOptions(
            card: card!,
            champion: champion!,
            context: context,
            sliderFixed: false,
          ),
        );
      },
      [],
    );

    return SizedBox(
      width: imageWidth,
      child: card == null
          ? Container(
              padding: const EdgeInsets.all(7),
              child: DottedBorder(
                strokeWidth: 1,
                radius: const Radius.circular(15),
                color: Colors.grey,
                borderType: BorderType.RRect,
                child: const SizedBox(
                  child: SizedBox(),
                ),
              ),
            )
          : _LoadoutCard(
              onPress: onPress ?? openLoadoutDetail,
              card: card!,
              imageWidth: imageWidth,
              imageHeight: imageHeight,
            ),
    );
  }
}

class _LoadoutCard extends StatelessWidget {
  final void Function() onPress;
  final models.Card card;
  final double imageWidth;
  final double imageHeight;

  const _LoadoutCard({
    Key? key,
    required this.onPress,
    required this.card,
    required this.imageWidth,
    required this.imageHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: InkWell(
        onTap: onPress,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: widgets.FastImage(
                imageUrl: card.imageUrl,
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
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
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          widgets.TextChip(
                            hidden: card.cooldown == 0,
                            spacing: 5,
                            text: '${card.cooldown.toInt().toString()} sec',
                            color: Colors.blueGrey,
                            icon: FontAwesomeIcons.hourglassEnd,
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
    );
  }
}
