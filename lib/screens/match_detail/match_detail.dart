import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/constants.dart' as constsnts;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class _MatchPlayer extends ConsumerWidget {
  // TODO: Send this widget in another file
  final models.MatchPlayer matchPlayer;
  const _MatchPlayer({
    required this.matchPlayer,
    Key? key,
  }) : super(key: key);

  String shortRankName(String rankName) {
    // TODO: Send this function in a utility file

    if (rankName.toLowerCase().contains("gran")) return "GM"; // Grandmaster
    if (rankName.toLowerCase().contains("mast")) return "MS"; // Master
    if (rankName.toLowerCase().contains("qual")) return "QL"; // Qualifying

    final temp = rankName.split(" ");
    final shortTier = temp.first[0];
    String tierLevel = "";

    if (temp[1] == "I") tierLevel = "1";
    if (temp[1] == "II") tierLevel = "2";
    if (temp[1] == "III") tierLevel = "3";
    if (temp[1] == "IV") tierLevel = "4";
    if (temp[1] == "V") tierLevel = "5";

    return '$shortTier$tierLevel';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final champions = ref.watch(providers.champions.select((_) => _.champions));

    final champion = champions.firstWhere(
      (champion) => champion.championId == matchPlayer.championId.toString(),
    );

    final talentUsed = champion.talents
        ?.firstWhere((_) => _.talentId2 == matchPlayer.talentId2);

    final kills = matchPlayer.playerStats.kills;
    final deaths = matchPlayer.playerStats.deaths;
    final assists = matchPlayer.playerStats.assists;
    final kda = deaths == 0
        ? "Perfect"
        : ((kills + assists) / deaths).toStringAsFixed(2);

    final isPrivatePlayer = matchPlayer.playerId == "0";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: Row(
        children: [
          widgets.FastImage(
            imageUrl: champion.iconUrl,
            height: 52,
            width: 52,
            borderRadius: const BorderRadius.all(Radius.circular(12.5)),
          ),
          matchPlayer.playerRanked == null
              ? const SizedBox(width: 20)
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      widgets.FastImage(
                        imageUrl: matchPlayer.playerRanked!.rankIconUrl!,
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        shortRankName(matchPlayer.playerRanked!.rankName!),
                        style: textTheme.bodyText1?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isPrivatePlayer ? 'Private Profile' : matchPlayer.playerName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      isPrivatePlayer ? FontWeight.normal : FontWeight.bold,
                  fontStyle:
                      isPrivatePlayer ? FontStyle.italic : FontStyle.normal,
                ),
              ),
              Row(
                children: [
                  talentUsed?.imageUrl != null
                      ? widgets.FastImage(
                          imageUrl: talentUsed!.imageUrl,
                          height: 32,
                          width: 32,
                        )
                      : const SizedBox(),
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Credits',
                        style: textTheme.bodyText1?.copyWith(
                          fontSize: 9,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        matchPlayer.playerStats.creditsEarned.toString(),
                        style: textTheme.bodyText1?.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$kills / $deaths / $assists  ($kda)',
                  style: textTheme.bodyText1?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: matchPlayer.playerChampionCards.map(
                    (playerChampionCard) {
                      final card = champion.cards?.firstWhere(
                        (_) => _.cardId2 == playerChampionCard.cardId2,
                      );
                      if (card == null) return const SizedBox();

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: widgets.FastImage(
                          imageUrl: card.imageUrl,
                          width: 32,
                          height: 32 / constsnts.ImageAspectRatios.championCard,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
                _MatchPlayer(matchPlayer: matchPlayer),
              ],
            ),
          );
        } else {
          matchPlayerWidgets.add(_MatchPlayer(matchPlayer: matchPlayer));
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
