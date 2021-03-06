import "package:dartx/dartx.dart";
import "package:expandable/expandable.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:jiffy/jiffy.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

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
    final playerChampions = ref.watch(
      providers.champions.select((_) => _.playerChampions),
    );

    // Variables
    final expandedController = ExpandableController(initialExpanded: false);
    final textTheme = Theme.of(context).textTheme;
    final isPrivatePlayer = playerInfo.player.playerId == "0";
    final winRate = playerInfo.ranked?.winRate;
    final winRateFormatted = playerInfo.ranked?.winRateFormatted;
    final champion = champions.firstOrNullWhere(
      (champion) => champion.championId == playerInfo.championId,
    );

    // Hooks
    final playerChampion = useMemoized(
      () {
        if (playerChampions == null) return null;

        return playerChampions.firstOrNullWhere(
          (_) => _.playerId == playerInfo.player.playerId,
        );
      },
      [playerChampions, playerInfo],
    );

    final championPlaytime = useMemoized(
      () {
        if (playerChampion == null) return null;

        final duration = Duration(minutes: playerChampion.playTime);
        if (duration.inHours == 0) return "${duration.inMinutes}min";

        return "${duration.inHours}h ${duration.inMinutes % 60}m";
      },
      [playerChampion],
    );

    final championLevel = useMemoized(
      () => playerChampion?.level.toString(),
      [playerChampion],
    );

    final championCPM = useMemoized(
      () {
        if (playerChampion == null) return null;

        final totalMatches = playerChampion.wins + playerChampion.losses;
        final totalCredits = playerChampion.totalCredits;
        final cpm = totalCredits / totalMatches;

        return "${cpm.round()} CR";
      },
      [playerChampion],
    );

    final championIcon = useMemoized(
      () {
        if (champion == null) return null;

        var championIcon = data_classes.PlatformOptimizedImage(
          imageUrl: champion.iconUrl,
          isAssetImage: false,
          blurHash: champion.iconBlurHash,
        );
        if (!constants.isWeb) {
          final assetUrl = utilities.getAssetImageUrl(
            constants.ChampionAssetType.icons,
            champion.championId,
          );
          if (assetUrl != null) {
            championIcon.imageUrl = assetUrl;
            championIcon.isAssetImage = true;
          }
        }

        return championIcon;
      },
      [champion],
    );

    // Methods
    final onTapPlayer = useCallback(
      () {
        if (isPrivatePlayer) return;

        utilities.Navigation.navigate(
          context,
          screens.PlayerDetail.routeName,
          params: {
            "playerId": playerInfo.player.playerId,
          },
        );
      },
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
          onTap: () => playerChampion == null
              ? widgets.showToast(
                  context: context,
                  text: "Stats not available for this player",
                  type: widgets.ToastType.info,
                )
              : expandedController.toggle(),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    championIcon == null
                        ? const SizedBox(height: 24 * 2, width: 24 * 2)
                        : widgets.ElevatedAvatar(
                            imageUrl: championIcon.imageUrl,
                            imageBlurHash: championIcon.blurHash,
                            isAssetImage: championIcon.isAssetImage,
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
                                ? "Private Profile"
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
                          "Level ${playerInfo.player.level}",
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
                            if (winRate != null && winRateFormatted != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: [
                                        const TextSpan(text: "WR "),
                                        TextSpan(
                                          text: "$winRateFormatted%",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: utilities
                                                .getWinRateColor(winRate),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "${playerInfo.ranked!.wins}W ${playerInfo.ranked!.looses}L",
                                    style: textTheme.bodyText1
                                        ?.copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            const SizedBox(width: 10),
                            ValueListenableBuilder<bool>(
                              valueListenable: expandedController,
                              builder: (context, isExpanded, _) {
                                if (playerChampion == null) {
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
                                            "Stats",
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
                  expanded: playerChampion != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  if (championPlaytime != null)
                                    _InfoLabel(
                                      label: "Play Time",
                                      text: championPlaytime,
                                    ),
                                  if (championLevel != null)
                                    _InfoLabel(
                                      label: "Champ. Lvl",
                                      text: championLevel,
                                    ),
                                  _InfoLabel(
                                    label: "Champ. WR",
                                    text: "${playerChampion.winRateFormatted}%",
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _InfoLabel(
                                    label: "KDA",
                                    text: playerChampion.kdaFormatted,
                                  ),
                                  if (championCPM != null)
                                    _InfoLabel(
                                      label: "CR / Match",
                                      text: championCPM,
                                    ),
                                  _InfoLabel(
                                    label: "Last Played",
                                    text: Jiffy(
                                      playerChampion.lastPlayed,
                                    ).fromNow(),
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
