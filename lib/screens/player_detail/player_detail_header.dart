import "dart:ui";

import "package:expandable/expandable.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/player_detail/player_detail_header_expandable_panel.dart";
import "package:paladinsedge/screens/player_detail/player_detail_status_indicator.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class PlayerDetailHeader extends HookConsumerWidget {
  const PlayerDetailHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final baseRanks = ref.watch(providers.baseRanks).baseRanks;
    final player = ref.watch(providers.players.select((_) => _.playerData));
    final playerInferred = ref.watch(
      providers.players.select((_) => _.playerInferred),
    );
    final playerId = ref.watch(
      providers.players.select((_) => _.playerData?.playerId),
    );

    // Variables
    final isSamePlayerInferred = playerId == playerInferred?.playerId;
    final textTheme = Theme.of(context).textTheme;
    final expandedController = ExpandableController(initialExpanded: false);

    // Hooks
    final playerBaseRank = useMemoized(
      () => baseRanks[player?.ranked.rank],
      [player, baseRanks],
    );

    final rankIcon = useMemoized(
      () {
        if (playerBaseRank == null) return null;

        var rankIcon = data_classes.PlatformOptimizedImage(
          imageUrl: utilities.getSmallAsset(playerBaseRank.rankIconUrl),
          isAssetImage: false,
        );
        if (!constants.isWeb) {
          final assetUrl = utilities.getAssetImageUrl(
            constants.ChampionAssetType.ranks,
            playerBaseRank.rank,
          );
          if (assetUrl != null) {
            rankIcon.imageUrl = assetUrl;
            rankIcon.isAssetImage = true;
          }
        }

        return rankIcon;
      },
      [playerBaseRank],
    );

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
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          widgets.ElevatedAvatar(
                            imageUrl: utilities.getSmallAsset(player.avatarUrl),
                            imageBlurHash: player.avatarBlurHash,
                            size: 30,
                            borderRadius: 10,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ValueListenableBuilder<bool>(
                                  valueListenable: expandedController,
                                  builder: (context, isExpanded, _) {
                                    return Row(
                                      children: [
                                        if (rankIcon != null)
                                          widgets.FastImage(
                                            imageUrl: rankIcon.imageUrl,
                                            isAssetImage: rankIcon.isAssetImage,
                                            height: 40,
                                            width: 40,
                                          ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              playerBaseRank!.rankName,
                                              style: textTheme.bodyMedium
                                                  ?.copyWith(fontSize: 14),
                                            ),
                                            Text(
                                              "${player.ranked.points} TP",
                                              style: textTheme.bodyLarge
                                                  ?.copyWith(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        const PlayerDetailStatusIndicator(),
                                        if (isSamePlayerInferred)
                                          AnimatedRotation(
                                            duration: const Duration(
                                              milliseconds: 200,
                                            ),
                                            turns: isExpanded ? 0.5 : 0,
                                            child: widgets.IconButton(
                                              iconSize: 22,
                                              onPressed:
                                                  expandedController.toggle,
                                              icon: Icons.keyboard_arrow_down,
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (isSamePlayerInferred)
                        ExpandablePanel(
                          controller: expandedController,
                          collapsed: const SizedBox(),
                          expanded: const PlayerDetailHeaderExpandablePanel(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
