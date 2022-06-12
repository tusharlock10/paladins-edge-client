import "dart:ui";

import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/player_detail/player_detail_status_indicator.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class PlayerDetailHeader extends ConsumerWidget {
  const PlayerDetailHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final player = ref.watch(providers.players.select((_) => _.playerData));

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return player == null
        ? const SizedBox()
        : IntrinsicHeight(
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 12.5,
                  sigmaY: 12.5,
                  tileMode: TileMode.mirror,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: scaffoldBackgroundColor.withOpacity(0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        widgets.ElevatedAvatar(
                          imageUrl: utilities.getSmallAsset(player.avatarUrl),
                          imageBlurHash: player.avatarBlurHash,
                          size: 24,
                          borderRadius: 10,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  widgets.FastImage(
                                    imageUrl: utilities.getSmallAsset(
                                      player.ranked.rankIconUrl,
                                    ),
                                    height: 36,
                                    width: 36,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        player.ranked.rankName,
                                        style: textTheme.bodyText2
                                            ?.copyWith(fontSize: 14),
                                      ),
                                      Text(
                                        "${player.ranked.points} TP",
                                        style: textTheme.bodyText1
                                            ?.copyWith(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const PlayerDetailStatusIndicator(),
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
            ),
          );
  }
}
