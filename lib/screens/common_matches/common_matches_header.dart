import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/theme/index.dart" as theme;

class CommonMatchesHeader extends HookConsumerWidget {
  final String playerId;

  const CommonMatchesHeader({
    required this.playerId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playerNotifier = providers.players(playerId);
    final appStateProvider = ref.read(providers.appState);
    final commonMatches = ref.watch(
      playerNotifier.select((_) => _.commonMatches),
    );
    final settings = ref.watch(
      providers.appState.select((_) => _.settings),
    );

    // Variables
    final textTheme = Theme.of(context).textTheme;

    // Hooks
    final commonMatchesStats = useMemoized(
      () {
        final commonMatchesStats = data_classes.CommonMatchesStats();

        if (commonMatches == null) return commonMatchesStats;
        final totalMatches = commonMatches.length;
        int sameTeamMatchesWon = 0;

        for (final commonMatch in commonMatches) {
          final matchPlayer1 = commonMatch.matchPlayers.first;
          final matchPlayer2 = commonMatch.matchPlayers.last;
          if (matchPlayer1.team == matchPlayer2.team) {
            commonMatchesStats.sameTeam++;
            sameTeamMatchesWon +=
                matchPlayer1.team == commonMatch.match.winningTeam ? 1 : 0;
          } else {
            commonMatchesStats.oppositeTeam++;
          }
        }
        commonMatchesStats.sameTeamWR = sameTeamMatchesWon * 100 / totalMatches;

        return commonMatchesStats;
      },
      [commonMatches],
    );

    // Methods
    final setShowUserPlayerMatches = useCallback(
      (bool? value) {
        final newSettings = settings.copyWith(showUserPlayerMatches: value);
        appStateProvider.setSettings(newSettings);
      },
      [settings],
    );

    return SliverPadding(
      padding: const EdgeInsets.only(top: 15),
      sliver: SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Same teams: ${commonMatchesStats.sameTeam}",
                    style: textTheme.bodyLarge?.copyWith(fontSize: 12),
                  ),
                  Text(
                    "Opposite team: ${commonMatchesStats.oppositeTeam}",
                    style: textTheme.bodyLarge?.copyWith(fontSize: 12),
                  ),
                  Text(
                    "WR on same team: ${commonMatchesStats.sameTeamWRFormatted}%",
                    style: textTheme.bodyLarge?.copyWith(fontSize: 12),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "My stats",
                    style: TextStyle(fontSize: 16),
                  ),
                  Checkbox(
                    value: settings.showUserPlayerMatches,
                    onChanged: setShowUserPlayerMatches,
                    activeColor: theme.themeMaterialColor,
                    hoverColor: theme.themeMaterialColor.shade300,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
