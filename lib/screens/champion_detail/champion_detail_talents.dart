import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class ChampionDetailTalents extends StatelessWidget {
  const ChampionDetailTalents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final champion =
        ModalRoute.of(context)?.settings.arguments as models.Champion;

    return Column(
      children: champion.talents.map(
        (talent) {
          return Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 5,
              ),
              child: Row(
                children: [
                  widgets.FastImage(
                    imageUrl: talent.imageUrl,
                    imageBlurHash: talent.imageBlurHash,
                    height: 114,
                    width: 114,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          talent.name.toUpperCase(),
                          style: textTheme.headline1?.copyWith(fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Wrap(
                            children: [
                              widgets.TextChip(
                                hidden: talent.modifier == "None",
                                spacing: 5,
                                text: talent.modifier,
                                color: Colors.teal,
                              ),
                              widgets.TextChip(
                                hidden: talent.cooldown == 0,
                                spacing: 5,
                                text:
                                    '${talent.cooldown.toInt().toString()} sec',
                                color: Colors.blueGrey,
                                icon: Icons.timelapse,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: ExpandText(
                            talent.description,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      fontSize: 14,
                                      color: textTheme.bodyText2?.color
                                          ?.withOpacity(0.8),
                                    ),
                          ),
                        ),
                      ],
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
