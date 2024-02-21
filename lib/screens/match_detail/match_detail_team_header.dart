import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/widgets/index.dart" as widgets;

class MatchDetailTeamHeader extends HookWidget {
  final data_classes.MatchTeamStats teamStats;
  final bool isWinningTeam;
  final List<models.Champion> bannedChampions;

  const MatchDetailTeamHeader({
    required this.teamStats,
    required this.isWinningTeam,
    required this.bannedChampions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Methods
    final getChampionIcon = useCallback(
      (models.Champion champion) {
        return data_classes.PlatformOptimizedImage(
          imageUrl: champion.iconUrl,
          blurHash: champion.iconBlurHash,
          assetType: constants.ChampionAssetType.icons,
          assetId: champion.championId,
        );
      },
      [],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isWinningTeam ? "VICTORY" : "DEFEATED",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: isWinningTeam ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(width: 15),
              Text(
                "${teamStats.kills} / ${teamStats.deaths} / ${teamStats.assists}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          if (bannedChampions.isNotEmpty)
            Row(
              children: bannedChampions.map(
                (bannedChampion) {
                  final championIcon = getChampionIcon(bannedChampion);

                  return widgets.ElevatedAvatar(
                    imageUrl: championIcon.imageUrl,
                    imageBlurHash: championIcon.blurHash,
                    isAssetImage: championIcon.isAssetImage,
                    size: 18,
                    greyedOut: true,
                  );
                },
              ).toList(),
            ),
        ],
      ),
    );
  }
}
