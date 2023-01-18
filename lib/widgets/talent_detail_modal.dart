import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

void showTalentDetailSheet(
  BuildContext context,
  models.ChampionTalent talent,
  models.Champion champion,
) {
  final screenWidth = MediaQuery.of(context).size.width;
  final width = utilities.responsiveCondition(
    context,
    desktop: screenWidth / 2.5,
    tablet: screenWidth / 1.5,
    mobile: screenWidth,
  );

  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    context: context,
    builder: (_) {
      return _TalentDetail(
        talent: talent,
        champion: champion,
      );
    },
    constraints: BoxConstraints(maxWidth: width),
  );
}

class _TalentDetail extends HookWidget {
  final models.ChampionTalent talent;
  final models.Champion champion;

  const _TalentDetail({
    required this.talent,
    required this.champion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;

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
                widgets.FastImage(
                  imageUrl: talent.imageUrl,
                  height: 76,
                  width: 76,
                  fit: BoxFit.cover,
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
                        style: textTheme.bodyText1?.copyWith(fontSize: 12),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        talent.name.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.headline1?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 2),
                      Wrap(
                        direction: Axis.horizontal,
                        children: [
                          if (talent.cooldown != 0)
                            widgets.TextChip(
                              spacing: 5,
                              text: "${talent.cooldown.toInt().toString()} sec",
                              color: Colors.blueGrey,
                              icon: Icons.timelapse,
                            ),
                          if (talent.modifier != "None")
                            widgets.TextChip(
                              spacing: 5,
                              text: talent.modifier,
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
                talent.description,
                textAlign: TextAlign.center,
                style: textTheme.bodyText2?.copyWith(fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
