import 'package:flutter/material.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class PlayerDetailHeader extends StatelessWidget {
  final models.Player player;
  final void Function() onForceUpdate;
  final bool isLoading;

  const PlayerDetailHeader({
    required this.player,
    required this.onForceUpdate,
    required this.isLoading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              widgets.ElevatedAvatar(
                size: 54,
                borderRadius: 10,
                imageUrl: player.avatarUrl,
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 54 * 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          player.name,
                          style: textTheme.headline3?.copyWith(fontSize: 20),
                        ),
                        player.title != null
                            ? Text(
                                player.title!,
                                style:
                                    textTheme.bodyText1?.copyWith(fontSize: 14),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    player.ranked != null
                        ? Row(
                            children: [
                              widgets.FastImage(
                                imageUrl: player.ranked!.rankIconUrl,
                                height: 46,
                                width: 46,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    player.ranked!.rankName,
                                    style: textTheme.bodyText2
                                        ?.copyWith(fontSize: 14),
                                  ),
                                  Text(
                                    '${player.ranked!.points} TP',
                                    style: textTheme.bodyText1
                                        ?.copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              widgets.UpdateButton(
                                lastUpdated: player.lastUpdatedPlayer,
                                onPressed: onForceUpdate,
                                isLoading: isLoading,
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
