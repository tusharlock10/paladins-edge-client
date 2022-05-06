import 'package:beamer/beamer.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/match_detail/match_detail_player.dart';
import 'package:paladinsedge/screens/match_detail/match_detail_stats.dart';
import 'package:paladinsedge/screens/match_detail/match_detail_team_header.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class MatchDetailList extends HookConsumerWidget {
  const MatchDetailList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchesProvider = ref.read(providers.matches);
    final matchId = context.currentBeamLocation.data as String;
    final isMatchDetailsLoading =
        ref.watch(providers.matches.select((_) => _.isMatchDetailsLoading));
    final matchDetails =
        ref.watch(providers.matches.select((_) => _.matchDetails));

    // Effects
    useEffect(
      () {
        // call matchDetail api
        matchesProvider.getMatchDetails(matchId);

        return matchesProvider.resetMatchDetails;
      },
      [],
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
            teamStats.kills += matchPlayer.playerStats.kills;
            teamStats.deaths += matchPlayer.playerStats.deaths;
            teamStats.assists += matchPlayer.playerStats.assists;
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
                  label: Text('Getting match'),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (matchDetails == null) {
      return SliverList(
        delegate: SliverChildListDelegate.fixed(
          [
            SizedBox(
              height: utilities.getBodyHeight(context),
              child: const Center(
                child: Text('Unable to fetch details for this match'),
              ),
            ),
          ],
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          final matchPlayer = matchDetails.matchPlayers[index];
          final previousMatchPlayer =
              matchDetails.matchPlayers.elementAtOrNull(index - 1);

          return Column(
            children: [
              if (index == 0) const MatchDetailStats(),
              if (matchPlayer.team != previousMatchPlayer?.team)
                MatchDetailTeamHeader(
                  teamStats: calculateTeamStats(
                    matchPlayer.team,
                    matchDetails.matchPlayers,
                  ),
                  isWinningTeam:
                      matchDetails.match.winningTeam == matchPlayer.team,
                  matchPlayer: matchPlayer,
                ),
              MatchDetailPlayer(matchPlayer: matchPlayer),
            ],
          );
        },
        childCount: matchDetails.matchPlayers.length,
      ),
    );
  }
}
