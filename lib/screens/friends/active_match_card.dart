import 'package:flutter/material.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class _PlayerMatch extends StatelessWidget {
  final models.ActiveMatch match;
  final int team;

  const _PlayerMatch({
    required this.match,
    required this.team,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final teamInfo = match.playersInfo.where((player) => player.team == team);
    final textTheme = Theme.of(context).textTheme;
    final shouldReverse = team == 2;

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: teamInfo.map(
          (player) {
            return widgets.ReversableRow(
              mainAxisAlignment: !shouldReverse
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              shouldReverse: shouldReverse,
              children: [
                widgets.ElevatedAvatar(
                  size: 20,
                  borderRadius: 20,
                  imageUrl: player.championImageUrl,
                ),
                Column(
                  crossAxisAlignment: !shouldReverse
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    Text(
                      player.player.playerId != "0"
                          ? player.player.playerName
                          : "Private Profile",
                      style: textTheme.bodyText1?.copyWith(fontSize: 12),
                    ),
                    player.ranked != null
                        ? widgets.ReversableRow(
                            shouldReverse: shouldReverse,
                            children: [
                              widgets.FastImage(
                                imageUrl: player.ranked!.rankIconUrl,
                                height: 16,
                                width: 16,
                              ),
                              Text(
                                player.ranked!.rankName,
                                style:
                                    textTheme.bodyText1?.copyWith(fontSize: 10),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            );
          },
        ).toList(),
      ),
    );
  }
}

class ActiveMatchCard extends StatelessWidget {
  final models.ActiveMatch? match;
  const ActiveMatchCard({
    required this.match,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (match == null) {
      return const SizedBox();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _PlayerMatch(match: match!, team: 1),
        _PlayerMatch(match: match!, team: 2),
      ],
    );
  }
}
