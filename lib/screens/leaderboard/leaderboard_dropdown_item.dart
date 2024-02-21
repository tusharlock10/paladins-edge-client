import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class LeaderboardDropdownItem extends HookWidget {
  final models.BaseRank baseRank;

  const LeaderboardDropdownItem({
    required this.baseRank,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Hooks
    final rankIcon = useMemoized(
      () {
        var rankIcon = data_classes.PlatformOptimizedImage(
          imageUrl: utilities.getSmallAsset(baseRank.rankIconUrl),
          isAssetImage: false,
        );
        if (!constants.isWeb) {
          final assetUrl = utilities.getAssetImageUrl(
            constants.ChampionAssetType.ranks,
            baseRank.rank,
          );
          if (assetUrl != null) {
            rankIcon.imageUrl = assetUrl;
            rankIcon.isAssetImage = true;
          }
        }

        return rankIcon;
      },
      [baseRank],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widgets.FastImage(
            imageUrl: rankIcon.imageUrl,
            isAssetImage: rankIcon.isAssetImage,
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 7),
          Text(baseRank.rankName),
        ],
      ),
    );
  }
}
