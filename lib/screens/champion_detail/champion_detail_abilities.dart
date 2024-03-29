import "package:dartx/dartx.dart";
import "package:expand_widget/expand_widget.dart";
import "package:flutter/material.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class ChampionDetailAbilities extends StatelessWidget {
  final models.Champion champion;
  const ChampionDetailAbilities({
    required this.champion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: champion.abilities.map(
        (ability) {
          final damageTypeChips =
              ability.damageType.split(",").map((damageType) {
            return constants.championDamageType[damageType];
          }).filterNotNull();

          return Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: widgets.ElevatedAvatar(
                          imageUrl: ability.imageUrl,
                          imageBlurHash: ability.imageBlurHash,
                          size: 36,
                          borderRadius: 10,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Text(
                              ability.name.toUpperCase(),
                              style:
                                  textTheme.displayLarge?.copyWith(fontSize: 18),
                            ),
                            const SizedBox(height: 5),
                            Wrap(children: [
                              ...damageTypeChips.map((damageTypeChip) {
                                return widgets.TextChip(
                                  spacing: 5,
                                  color: damageTypeChip.color,
                                  text: damageTypeChip.name,
                                  icon: damageTypeChip.icon,
                                );
                              }),
                              if (ability.cooldown != 0)
                                widgets.TextChip(
                                  spacing: 5,
                                  text:
                                      "${ability.cooldown.toInt().toString()} sec",
                                  color: Colors.blueGrey,
                                  icon: Icons.timelapse,
                                ),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: ExpandText(
                      utilities.convertAbilityDescription(
                        ability.description,
                      ),
                      indicatorIconSize: 24,
                      indicatorIconColor:
                          textTheme.bodyMedium?.color?.withOpacity(0.8),
                      maxLines: 3,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 13,
                            color: textTheme.bodyMedium?.color?.withOpacity(0.8),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
