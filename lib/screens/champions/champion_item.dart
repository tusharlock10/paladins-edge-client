import 'package:flutter/material.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class ChampionItem extends StatelessWidget {
  final models.Champion champion;
  final models.PlayerChampion? playerChampion;
  final double height;
  final double width;
  const ChampionItem({
    required this.champion,
    required this.playerChampion,
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    final textTheme = Theme.of(context).textTheme;
    MaterialColor levelColor = Colors.blueGrey;
    if (playerChampion?.level != null && playerChampion!.level > 49) {
      levelColor = Colors.orange;
    }

    return SizedBox(
      width: width,
      height: height,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          onTap: () => Navigator.of(context)
              .pushNamed(screens.ChampionDetail.routeName, arguments: champion),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Hero(
                    tag: '${champion.championId}Icon',
                    child: LayoutBuilder(
                      builder: (context, constraints) => widgets.ElevatedAvatar(
                        imageUrl: champion.iconUrl,
                        size: (constraints.maxHeight - 10) / 2,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          champion.name.toUpperCase(),
                          style: textTheme.headline1?.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Wrap(
                        children: [
                          widgets.TextChip(
                            spacing: 5,
                            text: champion.role,
                            color: theme.themeMaterialColor,
                          ),
                          widgets.TextChip(
                            spacing: 5,
                            hidden: playerChampion?.level == null,
                            text: 'Level ${playerChampion?.level.toString()}',
                            color: levelColor,
                          ),
                          widgets.TextChip(
                            spacing: 5,
                            hidden: !champion.onFreeRotation,
                            text: 'Free',
                            icon: Icons.rotate_right,
                            color: Colors.green,
                          ),
                          widgets.TextChip(
                            spacing: 5,
                            hidden: !champion.latestChampion,
                            text: 'New',
                            icon: Icons.star,
                            color: Colors.orange,
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
      ),
    );
  }
}
