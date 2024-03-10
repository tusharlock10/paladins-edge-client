import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/models/active_match/active_match.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/active_match/active_match_player.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;

class ActiveMatchList extends HookConsumerWidget {
  final String playerId;

  const ActiveMatchList({
    required this.playerId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playerNotifier = providers.players(playerId);
    final playerStatus = ref.watch(
      playerNotifier.select((_) => _.playerStatus),
    );

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final isLandscape = utilities.responsiveCondition(
      context,
      desktop: true,
      tablet: true,
      mobile: false,
    );
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = utilities.responsiveCondition(
      context,
      desktop: screenWidth * 0.125,
      tablet: 15.0,
      mobile: 15.0,
    );

    // Hooks
    final playersInfoTeam1 = useMemoized(
      () {
        final team = playerStatus?.match?.playersInfo.where((_) => _.team == 1);
        if (team == null) return List<ActiveMatchPlayersInfo>.empty();

        return team.toList();
      },
      [playerStatus],
    );

    final playersInfoTeam2 = useMemoized(
      () {
        final team = playerStatus?.match?.playersInfo.where((_) => _.team == 2);
        if (team == null) return List<ActiveMatchPlayersInfo>.empty();

        return team.toList();
      },
      [playerStatus],
    );

    return playerStatus == null
        ? const SizedBox()
        : SliverPadding(
            padding: isLandscape
                ? EdgeInsets.symmetric(horizontal: horizontalPadding)
                : EdgeInsets.zero,
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  const SizedBox(height: 20),
                  if (playerStatus.match != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          playerStatus.status,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${playerStatus.match?.map}",
                          style: textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${playerStatus.match?.region}",
                          style: textTheme.bodyLarge?.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "Team 1",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...playersInfoTeam1.map(
                    (playerInfo) {
                      return ActiveMatchPlayer(
                        playerInfo: playerInfo,
                      );
                    },
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Team 2",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  ...playersInfoTeam2.map(
                    (playerInfo) {
                      return ActiveMatchPlayer(
                        playerInfo: playerInfo,
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
  }
}
