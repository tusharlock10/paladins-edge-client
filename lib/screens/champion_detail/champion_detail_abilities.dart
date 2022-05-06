import 'package:beamer/beamer.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class ChampionDetailAbilities extends StatelessWidget {
  const ChampionDetailAbilities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final champion = context.currentBeamLocation.data as models.Champion;

    return Column(
      children: champion.abilities.map(
        (ability) {
          final damageTypeChips =
              ability.damageType.split(',').map((damageType) {
            return constants.championDamageType[damageType];
          });

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
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Text(
                                  ability.name.toUpperCase(),
                                  style: textTheme.headline1
                                      ?.copyWith(fontSize: 18),
                                ),
                              ),
                            ),
                            Wrap(children: [
                              ...damageTypeChips.map((damageTypeChip) {
                                return widgets.TextChip(
                                  spacing: 5,
                                  hidden: damageTypeChip == null,
                                  color:
                                      damageTypeChip?.color as MaterialColor?,
                                  text: damageTypeChip?.name,
                                  icon: damageTypeChip?.icon,
                                );
                              }),
                              widgets.TextChip(
                                hidden: ability.cooldown == 0,
                                spacing: 5,
                                text:
                                    '${ability.cooldown.toInt().toString()} sec',
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
                      maxLines: 3,
                      arrowSize: 24,
                      overflow: TextOverflow.fade,
                      arrowColor: textTheme.bodyText2?.color?.withOpacity(0.8),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontSize: 13,
                            color: textTheme.bodyText2?.color?.withOpacity(0.8),
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
