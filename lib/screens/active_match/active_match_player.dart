import 'package:dartx/dartx.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
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
    final playersProvider = ref.read(providers.players);
    final playerChampions =
        ref.watch(providers.champions.select((_) => _.playerChampions));

    // Variables
    final expandedController = ExpandableController(initialExpanded: false);
    final textTheme = Theme.of(context).textTheme;
    final isPrivatePlayer = playerInfo.player.playerId == "0";
    double? winRate = playerInfo.ranked != null
        ? playerInfo.ranked!.wins *
            100 /
            (playerInfo.ranked!.wins + playerInfo.ranked!.looses)
        : null;
    winRate =
        winRate == double.nan || winRate == double.infinity ? null : winRate;
    final champion = champions.firstOrNullWhere(
      (_champion) => _champion.championId == playerInfo.championId,
    );

    // State
    final playerChampion = useState<models.PlayerChampion?>(null);

    // Effects
    useEffect(
      () {
        if (playerChampions != null) {
          playerChampion.value = playerChampions.firstOrNullWhere(
            (_) => _.playerId == playerInfo.player.playerId,
          );
        }

        return null;
      },
      [playerChampions],
    );

    // Methods
    final onTapPlayer = useCallback(
      () {
        if (isPrivatePlayer) return;

        playersProvider.setPlayerId(playerInfo.player.playerId);
        Navigator.of(context).pushNamed(screens.PlayerDetail.routeName);
      },
      [],
    );

    final getWinRateColor = useCallback(
      (double? winRate) {
        if (winRate == null) {
          return null;
        } else if (winRate < 49) {
          return Colors.red;
        } else if (winRate < 52) {
          return textTheme.headline3?.color;
        } else {
          return Colors.green;
        }
      },
      [],
    );

    final getChampionPlaytime = useCallback(
      () {
        final duration = Duration(minutes: playerChampion.value!.playTime);
        if (duration.inHours == 0) return '${duration.inMinutes}min';

        return '${duration.inHours}h ${duration.inMinutes % 60}m';
      },
      [],
    );

    final getChampionLevel = useCallback(
      () => playerChampion.value!.level.toString(),
      [],
    );

    final getChampionWinRate = useCallback(
      () {
        final wins = playerChampion.value!.wins;
        final totalMatches = wins + playerChampion.value!.losses;
        final winRate = wins * 100 / totalMatches;

        if (winRate == double.nan || winRate == double.nan) return '';

        return '${winRate.toStringAsPrecision(3)}%';
      },
      [],
    );

    final getChampionKDA = useCallback(
      () {
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
        final totalMatches =
            playerChampion.value!.wins + playerChampion.value!.losses;
        final totalCredits = playerChampion.value!.totalCredits;
        final cpm = totalCredits / totalMatches;

        return '${cpm.round()} CR';
      },
      [],
    );

    final getPlayerLastPlayed = useCallback(
      () => Jiffy(
        playerChampion.value!.lastPlayed,
      ).fromNow(),
      [],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: InkWell(
          onTap: () => playerChampion.value == null
              ? widgets.showToast(
                  context: context,
                  text: 'Stats not available for this player',
                  type: widgets.ToastType.info,
                )
              : expandedController.toggle(),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    champion == null
                        ? const SizedBox(height: 24 * 2, width: 24 * 2)
                        : widgets.ElevatedAvatar(
                            imageUrl: champion.iconUrl,
                            imageBlurHash: champion.iconBlurHash,
                            borderRadius: 7.5,
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
                                  utilities.shortRankName(
                                    playerInfo.ranked!.rankName,
                                  ),
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
                        GestureDetector(
                          onTap: onTapPlayer,
                          child: Text(
                            isPrivatePlayer
                                ? 'Private Profile'
                                : playerInfo.player.playerName,
                            style: TextStyle(
                              decoration: isPrivatePlayer
                                  ? TextDecoration.none
                                  : TextDecoration.underline,
                              fontSize: 16,
                              fontWeight: isPrivatePlayer
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                              fontStyle: isPrivatePlayer
                                  ? FontStyle.italic
                                  : FontStyle.normal,
                            ),
                          ),
                        ),
                        Text(
                          'Level ${playerInfo.player.level}',
                          style: textTheme.bodyText1?.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (winRate != null)
                              Column(
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
                                    style: textTheme.bodyText1
                                        ?.copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            const SizedBox(width: 10),
                            ValueListenableBuilder<bool>(
                              valueListenable: expandedController,
                              builder: (context, isExpanded, _) {
                                if (playerChampion.value == null) {
                                  return const SizedBox();
                                }

                                return Row(
                                  children: [
                                    if (champion != null)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Stats',
                                            style: textTheme.bodyText1
                                                ?.copyWith(fontSize: 10),
                                          ),
                                          Text(
                                            champion.name,
                                            style: textTheme.bodyText1
                                                ?.copyWith(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    AnimatedRotation(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      turns: isExpanded ? 0.5 : 0,
                                      child: const Icon(
                                        Icons.keyboard_arrow_down,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                ExpandablePanel(
                  controller: expandedController,
                  collapsed: const SizedBox(),
                  expanded: playerChampion.value != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _InfoLabel(
                                    label: 'Play Time',
                                    text: getChampionPlaytime(),
                                  ),
                                  _InfoLabel(
                                    label: 'Champ. Lvl',
                                    text: getChampionLevel(),
                                  ),
                                  _InfoLabel(
                                    label: 'Champ. WR',
                                    text: getChampionWinRate(),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                    text: getPlayerLastPlayed(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
