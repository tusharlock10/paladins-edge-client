import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class AppDrawerPlayerProfile extends HookConsumerWidget {
  const AppDrawerPlayerProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final baseRanks = ref.watch(providers.baseRanks).baseRanks;
    final player = ref.watch(providers.auth.select((_) => _.userPlayer));

    // Variables
    final textTheme = Theme.of(context).textTheme;

    // Hooks
    final rankIcon = useMemoized(
      () {
        final playerBaseRank = baseRanks[player?.ranked.rank];
        if (playerBaseRank == null) return null;

        return data_classes.PlatformOptimizedImage(
          imageUrl: utilities.getSmallAsset(playerBaseRank.rankIconUrl),
          assetType: constants.ChampionAssetType.ranks,
          assetId: playerBaseRank.rank,
        );
      },
      [player, baseRanks],
    );

    // Methods
    final onTapPlayer = useCallback(
      () {
        if (player == null) return;

        utilities.Navigation.navigate(
          context,
          screens.PlayerDetail.routeName,
          params: {
            "playerId": player.playerId,
          },
        );
      },
      [],
    );

    if (player == null) {
      return const SizedBox();
    }

    return GestureDetector(
      onTap: onTapPlayer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widgets.ElevatedAvatar(
            imageUrl: player.avatarUrl,
            imageBlurHash: player.avatarBlurHash,
            size: 20,
            borderRadius: 5,
            elevation: 7,
          ),
          const SizedBox(width: 7),
          Column(
            children: [
              Text(
                player.name,
                style: textTheme.displayLarge?.copyWith(
                  fontSize: 18,
                ),
              ),
              player.title != null
                  ? Text(
                      player.title!,
                      style: textTheme.bodyLarge?.copyWith(fontSize: 12),
                    )
                  : const SizedBox(),
            ],
          ),
          const SizedBox(width: 7),
          rankIcon != null
              ? widgets.FastImage(
                  imageUrl: rankIcon.optimizedUrl,
                  isAssetImage: rankIcon.isAssetImage,
                  height: 30,
                  width: 30,
                )
              : const SizedBox(width: 20),
        ],
      ),
    );
  }
}
