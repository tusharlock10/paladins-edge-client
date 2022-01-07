import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class _InfoLabel extends StatelessWidget {
  final String label;
  final String text;

  const _InfoLabel({
    required this.label,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        Container(
          height: 0.8,
          width: 72,
          color: theme.darkThemeMaterialColor,
          margin: const EdgeInsets.symmetric(vertical: 4),
        ),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ActiveMatchPlayer extends HookConsumerWidget {
  final models.ActiveMatchPlayersInfo playerInfo;

  const ActiveMatchPlayer({
    required this.playerInfo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final champions = ref.read(providers.champions).champions;

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final isPrivatePlayer = playerInfo.player.playerId == "0";
    final winRate = playerInfo.ranked != null
        ? playerInfo.ranked!.wins *
            100 /
            (playerInfo.ranked!.wins + playerInfo.ranked!.looses)
        : null;
    final champion = champions.firstWhere(
      (_champion) => _champion.championId == playerInfo.championId.toString(),
    );

    // State
    final playerChampion = useState<models.PlayerChampion?>(null);

    // Methods
    final getWinRateColor = useCallback(
      (double? winRate) {
        if (winRate == null) {
          return null;
        } else if (winRate < 49) {
          return Colors.red;
        } else if (winRate < 52) {
          return Colors.white;
        } else {
          return Colors.green;
        }
      },
      [],
    );

    final getPlayerChampion = useCallback(
      () async {
        if (isPrivatePlayer) return;

        final response = await api.ChampionsRequests.playerChampions(
          playerId: playerInfo.player.playerId,
        );

        if (response != null) {
          playerChampion.value = response.playerChampions.firstWhere(
            (_playerChampion) =>
                _playerChampion.championId == champion.championId,
          );
        }
      },
      [],
    );

    final getChampionPlaytime = useCallback(
      () {
        final duration = Duration(minutes: playerChampion.value!.playTime);

        if (duration.inHours == 0) {
          return '${duration.inMinutes}min';
        }

        return '${duration.inHours}h ${duration.inMinutes % 60}m';
      },
      [],
    );

    final getChampionWinRate = useCallback(
      () {
        if (playerChampion.value == null) return '';
        final wins = playerChampion.value!.wins;
        final totalMatches = wins + playerChampion.value!.losses;
        final winRate = wins * 100 / totalMatches;

        return '${winRate.toStringAsPrecision(3)}%';
      },
      [],
    );

    final getChampionKDA = useCallback(
      () {
        if (playerChampion.value == null) return '';
        final kills = playerChampion.value!.totalKills;
        final deaths = playerChampion.value!.totalDeaths;
        final assists = playerChampion.value!.totalAssists;

        final kda = (kills + assists) / deaths;

        return kda.toStringAsPrecision(3);
      },
      [],
    );

    final getChampionCPM = useCallback(
      () {
        if (playerChampion.value == null) return '';
        final totalMatches =
            playerChampion.value!.wins + playerChampion.value!.losses;
        final totalCredits = playerChampion.value!.totalCredits;

        final cpm = totalCredits / totalMatches;

        return '${cpm.round()} CR';
      },
      [],
    );

    // Effects
    useEffect(
      () {
        // get the player champion from paladins api
        getPlayerChampion();
      },
      [],
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Column(
          children: [
            Row(
              children: [
                widgets.ElevatedAvatar(
                  imageUrl: champion.iconUrl,
                  size: 24,
                ),
                playerInfo.ranked == null
                    ? const SizedBox(width: 20)
                    : Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            widgets.FastImage(
                              imageUrl: playerInfo.ranked!.rankIconUrl,
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              utilities
                                  .shortRankName(playerInfo.ranked!.rankName),
                              style: textTheme.bodyText1?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isPrivatePlayer
                          ? 'Private Profile'
                          : playerInfo.player.playerName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isPrivatePlayer
                            ? FontWeight.normal
                            : FontWeight.bold,
                        fontStyle: isPrivatePlayer
                            ? FontStyle.italic
                            : FontStyle.normal,
                      ),
                    ),
                    Text(
                      'Level ${playerInfo.player.level.toString()}',
                      style: textTheme.bodyText1?.copyWith(fontSize: 12),
                    ),
                  ],
                ),
                winRate != null
                    ? Flexible(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: [
                                    const TextSpan(text: 'WR '),
                                    TextSpan(
                                      text:
                                          '${winRate.toStringAsPrecision(3)}%',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: getWinRateColor(winRate),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${playerInfo.ranked!.wins}W ${playerInfo.ranked!.looses}L',
                                style:
                                    textTheme.bodyText1?.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            playerChampion.value != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _InfoLabel(
                              label: 'Play Time',
                              text: getChampionPlaytime(),
                            ),
                            _InfoLabel(
                              label: 'Champ. Lvl',
                              text: playerChampion.value!.level.toString(),
                            ),
                            _InfoLabel(
                              label: 'Champ. WR',
                              text: getChampionWinRate(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _InfoLabel(
                              label: 'KDA',
                              text: getChampionKDA(),
                            ),
                            _InfoLabel(
                              label: 'CR / Match',
                              text: getChampionCPM(),
                            ),
                            _InfoLabel(
                              label: 'Last Played',
                              text: Jiffy(
                                playerChampion.value!.lastPlayed,
                              ).fromNow(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
