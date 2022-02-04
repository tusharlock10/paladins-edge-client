import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/match_detail/match_player.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class MatchDetail extends HookConsumerWidget {
  static const routeName = '/matchDetail';

  const MatchDetail({Key? key}) : super(key: key);

  Map<String, int> calculateTeamStats(
    int team,
    List<models.MatchPlayer> matchPlayers,
  ) {
    int kills = 0;
    int deaths = 0;
    int assists = 0;

    for (var matchPlayer in matchPlayers) {
      if (matchPlayer.team == team) {
        kills += matchPlayer.playerStats.kills;
        deaths += matchPlayer.playerStats.deaths;
        assists += matchPlayer.playerStats.assists;
      }
    }

    return {
      'kills': kills,
      'deaths': deaths,
      'assists': assists,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchesProvider = ref.read(providers.matches);
    final matchId = ModalRoute.of(context)?.settings.arguments as String;
    final matchDetails = ref.watch(
      providers.matches.select((_) => _.matchDetails),
    );

    // sort players based on their team
    matchDetails?.matchPlayers.sort((a, b) => a.team - b.team);

    useEffect(
      () {
        // call matchDetail api
        matchesProvider.getMatchDetails(matchId);

        return matchesProvider.resetMatchDetails;
      },
      [],
    );

    final List<Widget> matchPlayerWidgets = [];

    if (matchDetails?.matchPlayers != null) {
      for (int index = 0; index < matchDetails!.matchPlayers.length; index++) {
        final matchPlayer = matchDetails.matchPlayers[index];

        if (index == 0 || index == 5) {
          final teamStats =
              calculateTeamStats(matchPlayer.team, matchDetails.matchPlayers);
          final isWinningTeam =
              matchDetails.match.winningTeam == matchPlayer.team;

          matchPlayerWidgets.add(
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isWinningTeam ? 'WON' : 'LOST',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: isWinningTeam ? Colors.green : Colors.red,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'Team ${matchPlayer.team}',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        '${teamStats['kills']} / ${teamStats['deaths']} / ${teamStats['assists']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                MatchPlayer(matchPlayer: matchPlayer),
              ],
            ),
          );
        } else {
          matchPlayerWidgets.add(MatchPlayer(matchPlayer: matchPlayer));
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Match Detail"),
      ),
      body: matchDetails == null
          ? const Center(
              child: widgets.LoadingIndicator(
                size: 36,
              ),
            )
          : ListView(
              children: matchPlayerWidgets,
            ),
    );
  }
}
