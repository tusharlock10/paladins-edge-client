import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
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
    // Providers
    final matchesProvider = !isSavedMatch ? ref.read(providers.matches) : null;
    final isMatchDetailsLoading = !isSavedMatch
        ? ref.watch(providers.matches.select((_) => _.isMatchDetailsLoading))
        : false;

    // Variables
    final matchPlayers = combinedMatch?.matchPlayers;
    final match = combinedMatch?.match;

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

    final winningTeamMatchPlayers = useMemoized(
      () {
        return matchPlayers
                ?.where((_) => _.team == match?.winningTeam)
                .toList() ??
            [];
      },
      [matchPlayers, match],
    );

    final losingTeamMatchPlayers = useMemoized(
      () {
        return matchPlayers
                ?.where((_) => _.team != match?.winningTeam)
                .toList() ??
            [];
      },
      [matchPlayers, match],
    );

    final winningTeamStats = useMemoized(
      () {
        final teamStats = data_classes.MatchTeamStats(
          kills: 0,
          deaths: 0,
          assists: 0,
        );
        if (winningTeamMatchPlayers.isEmpty) return null;

        for (final matchPlayer in winningTeamMatchPlayers) {
          teamStats.kills += matchPlayer.playerStats.kills.toInt();
          teamStats.deaths += matchPlayer.playerStats.deaths.toInt();
          teamStats.assists += matchPlayer.playerStats.assists.toInt();
        }

        return teamStats;
      },
      [winningTeamMatchPlayers],
    );

    final losingTeamStats = useMemoized(
      () {
        final teamStats = data_classes.MatchTeamStats(
          kills: 0,
          deaths: 0,
          assists: 0,
        );
        if (losingTeamMatchPlayers.isEmpty) return null;

        for (final matchPlayer in losingTeamMatchPlayers) {
          teamStats.kills += matchPlayer.playerStats.kills.toInt();
          teamStats.deaths += matchPlayer.playerStats.deaths.toInt();
          teamStats.assists += matchPlayer.playerStats.assists.toInt();
        }

        return teamStats;
      },
      [losingTeamMatchPlayers],
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

    return SliverToBoxAdapter(
      child: Column(
        children: [
          MatchDetailStats(combinedMatch: combinedMatch),
          if (winningTeamStats != null)
            MatchDetailTeamHeader(
              teamStats: winningTeamStats,
              isWinningTeam: true,
            ),
          for (int playerIndex = 0;
              playerIndex < winningTeamMatchPlayers.length;
              playerIndex++)
            MatchDetailPlayerCard(
              matchPlayer: winningTeamMatchPlayers[playerIndex],
              averageCredits: averageCredits,
            ),
          if (losingTeamStats != null)
            MatchDetailTeamHeader(
              teamStats: losingTeamStats,
              isWinningTeam: false,
            ),
          for (int playerIndex = 0;
              playerIndex < losingTeamMatchPlayers.length;
              playerIndex++)
            MatchDetailPlayerCard(
              matchPlayer: losingTeamMatchPlayers[playerIndex],
              averageCredits: averageCredits,
            ),
        ],
      ),
    );
  }
}
