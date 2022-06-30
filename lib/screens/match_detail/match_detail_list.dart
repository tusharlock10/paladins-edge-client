import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/match_detail/match_detail_player_card.dart";
import "package:paladinsedge/screens/match_detail/match_detail_stats.dart";
import "package:paladinsedge/screens/match_detail/match_detail_team_header.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class MatchDetailList extends HookConsumerWidget {
  final String matchId;
  final data_classes.CombinedMatch? combinedMatch;
  final bool isSavedMatch;
  const MatchDetailList({
    required this.matchId,
    required this.combinedMatch,
    required this.isSavedMatch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchesProvider = !isSavedMatch ? ref.read(providers.matches) : null;
    final isMatchDetailsLoading = !isSavedMatch
        ? ref.watch(providers.matches.select((_) => _.isMatchDetailsLoading))
        : false;

    // Effects
    useEffect(
      () {
        if (matchesProvider == null) return null;
        // call matchDetail api
        matchesProvider.getMatchDetails(matchId);

        return matchesProvider.resetMatchDetails;
      },
      [],
    );

    // Hooks
    final averageCredits = useMemoized(
      () {
        if (combinedMatch == null) return double.maxFinite;

        final totalCredits = combinedMatch!.matchPlayers
            .map((matchPlayer) => matchPlayer.playerStats.creditsEarned)
            .reduce((value, creditsEarned) => value + creditsEarned);

        return totalCredits / combinedMatch!.matchPlayers.length;
      },
      [combinedMatch],
    );

    // Methods
    final calculateTeamStats = useCallback(
      (
        int team,
        List<models.MatchPlayer> matchPlayers,
      ) {
        final teamStats = data_classes.MatchTeamStats(
          kills: 0,
          deaths: 0,
          assists: 0,
        );
        for (var matchPlayer in matchPlayers) {
          if (matchPlayer.team == team) {
            teamStats.kills += matchPlayer.playerStats.kills.toInt();
            teamStats.deaths += matchPlayer.playerStats.deaths.toInt();
            teamStats.assists += matchPlayer.playerStats.assists.toInt();
          }
        }

        return teamStats;
      },
      [],
    );

    if (isMatchDetailsLoading) {
      return SliverList(
        delegate: SliverChildListDelegate.fixed(
          [
            SizedBox(
              height: utilities.getBodyHeight(context),
              child: const Center(
                child: widgets.LoadingIndicator(
                  lineWidth: 2,
                  size: 28,
                  label: Text("Getting match"),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (combinedMatch == null) {
      return SliverList(
        delegate: SliverChildListDelegate.fixed(
          [
            SizedBox(
              height: utilities.getBodyHeight(context),
              child: const Center(
                child: Text("Unable to fetch details for this match"),
              ),
            ),
          ],
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          final matchPlayer = combinedMatch!.matchPlayers[index];
          final previousMatchPlayer =
              combinedMatch!.matchPlayers.elementAtOrNull(index - 1);

          return Column(
            children: [
              if (index == 0) MatchDetailStats(combinedMatch: combinedMatch),
              if (matchPlayer.team != previousMatchPlayer?.team)
                MatchDetailTeamHeader(
                  teamStats: calculateTeamStats(
                    matchPlayer.team,
                    combinedMatch!.matchPlayers,
                  ),
                  isWinningTeam:
                      combinedMatch!.match.winningTeam == matchPlayer.team,
                  matchPlayer: matchPlayer,
                ),
              MatchDetailPlayerCard(
                matchPlayer: matchPlayer,
                averageCredits: averageCredits,
              ),
            ],
          );
        },
        childCount: combinedMatch!.matchPlayers.length,
      ),
    );
  }
}
