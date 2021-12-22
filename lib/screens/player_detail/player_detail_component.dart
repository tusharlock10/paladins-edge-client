import 'package:flutter/material.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class PlayerDetailComponent extends StatelessWidget {
  final models.Player player;

  const PlayerDetailComponent({
    required this.player,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              widgets.ElevatedAvatar(
                size: 48,
                borderRadius: 10,
                imageUrl: player.avatarUrl!,
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player.name,
                    style: theme.textTheme.headline3?.copyWith(fontSize: 22),
                  ),
                  player.title != null
                      ? Text(
                          player.title!,
                          style:
                              theme.textTheme.bodyText1?.copyWith(fontSize: 14),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      player.ranked.rankIconUrl != null
                          ? widgets.FastImage(
                              imageUrl: player.ranked.rankIconUrl!,
                              height: 42,
                              width: 42,
                            )
                          : const SizedBox(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${player.ranked.rankName}',
                            style: theme.textTheme.bodyText2
                                ?.copyWith(fontSize: 11),
                          ),
                          Text(
                            '${player.ranked.points} TP',
                            style: theme.textTheme.bodyText1
                                ?.copyWith(fontSize: 11),
                          )
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
