import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class LeaderboardPlayer extends HookWidget {
  final models.LeaderboardPlayer leaderboardPlayer;

  const LeaderboardPlayer({
    required this.leaderboardPlayer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final basicPlayer = leaderboardPlayer.basicPlayer;
    final playerRanked = leaderboardPlayer.ranked;
    final title = basicPlayer.title ?? "";
    final theme = Theme.of(context);
    final winRate = playerRanked.winRate;
    final winRateFormatted = playerRanked.winRateFormatted;
    final winRateColor =
        winRate == null ? null : utilities.getWinRateColor(winRate);

    // Methods
    final onPressLeaderboardPlayer = useCallback(
      () {
        utilities.Navigation.navigate(
          context,
          screens.PlayerDetail.routeName,
          params: {
            "playerId": basicPlayer.playerId,
          },
        );
      },
      [basicPlayer],
    );

    return widgets.InteractiveCard(
      elevation: 7,
      borderRadius: 10,
      onTap: onPressLeaderboardPlayer,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          widgets.ElevatedAvatar(
            imageUrl: basicPlayer.avatarUrl,
            imageBlurHash: basicPlayer.avatarBlurHash,
            size: 34,
            borderRadius: 5,
            elevation: 7,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    basicPlayer.name,
                    style: theme.textTheme.displayLarge?.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                if (title != "")
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
                  ),
                Text(
                  "${leaderboardPlayer.platform} | ${leaderboardPlayer.region}",
                  style: theme.textTheme.bodyLarge?.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
          if (winRateFormatted != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "TP ${playerRanked.points} | Rank ${leaderboardPlayer.position}",
                  style: theme.textTheme.bodyLarge?.copyWith(fontSize: 10),
                ),
                Text(
                  "$winRateFormatted % WR",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: winRateColor,
                  ),
                ),
                Text(
                  "${playerRanked.matches} Matches",
                  style: theme.textTheme.bodyLarge?.copyWith(fontSize: 12),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
