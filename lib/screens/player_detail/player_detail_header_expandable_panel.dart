import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:jiffy/jiffy.dart";
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/widgets/index.dart" as widgets;

class _RecentPartyMemberCard extends StatelessWidget {
  static const itemHeight = 60.0;
  static const itemWidth = 200.0;
  final models.BasicPlayer player;
  const _RecentPartyMemberCard({
    required this.player,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: itemWidth,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: 10,
            right: 10,
          ),
          child: Row(
            children: [
              widgets.ElevatedAvatar(
                imageUrl: player.avatarUrl,
                imageBlurHash: player.avatarBlurHash,
                size: 18,
                borderRadius: 8,
                elevation: 3,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      player.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.headline1?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    if (player.title != null)
                      Text(
                        player.title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyText1?.copyWith(fontSize: 9.5),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentlyPlayedChampionCard extends HookWidget {
  static const itemHeight = 90.0;
  static const itemWidth = 190.0;
  final models.Champion champion;
  final models.PlayerChampion? playerChampion;

  const _RecentlyPlayedChampionCard({
    required this.champion,
    required this.playerChampion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;
    final winRate = playerChampion != null
        ? playerChampion!.wins *
            100 /
            (playerChampion!.losses + playerChampion!.wins)
        : null;
    final winRateFormatted = winRate?.toStringAsPrecision(3);
    final lastPlayed = playerChampion?.lastPlayed;
    final kda = playerChampion != null
        ? (playerChampion!.totalKills + playerChampion!.totalAssists) /
            playerChampion!.totalDeaths
        : null;
    final kdaFormatted = kda?.toStringAsPrecision(3);

    // Hooks
    final lastPlayedFormatted = useMemoized(
      () {
        if (lastPlayed == null) return "";

        final duration = DateTime.now().difference(lastPlayed);
        if (duration > const Duration(days: 1)) {
          return "Last played ${Jiffy(lastPlayed).yMMMd}";
        }

        return "Played ${Jiffy(lastPlayed).fromNow()}";
      },
      [lastPlayed],
    );
    final winRateColor = useMemoized(
      () {
        if (winRate == null) return null;
        if (winRate < 49) return Colors.red;
        if (winRate < 52) return null;

        return Colors.green;
      },
      [winRate],
    );
    final kdaColor = useMemoized(
      () {
        if (kda == null) return null;
        if (kda > 3.8) return Colors.green.shade200;
        if (kda > 3) return Colors.orange.shade200;
        if (kda < 1) return Colors.red.shade200;

        return null;
      },
      [kda],
    );

    return SizedBox(
      width: itemWidth,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: 10,
            right: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Row(
                children: [
                  widgets.ElevatedAvatar(
                    imageUrl: champion.iconUrl,
                    imageBlurHash: champion.iconBlurHash,
                    size: 18,
                    borderRadius: 8,
                    elevation: 3,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          champion.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.headline1?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          champion.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyText1?.copyWith(fontSize: 9.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (playerChampion != null) const SizedBox(height: 5),
              if (playerChampion != null)
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "WR ",
                        style: textTheme.bodyText1?.copyWith(fontSize: 11),
                        children: [
                          TextSpan(
                            text: winRateFormatted,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: winRateColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    RichText(
                      text: TextSpan(
                        text: "LVL ",
                        style: textTheme.bodyText1?.copyWith(fontSize: 11),
                        children: [
                          TextSpan(
                            text: playerChampion!.level.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    RichText(
                      text: TextSpan(
                        text: "KDA ",
                        style: textTheme.bodyText1?.copyWith(fontSize: 11),
                        children: [
                          TextSpan(
                            text: kdaFormatted,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kdaColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              if (playerChampion != null) const SizedBox(height: 5),
              if (lastPlayedFormatted.isNotEmpty)
                Text(
                  lastPlayedFormatted,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyText1?.copyWith(fontSize: 10),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerDetailHeaderExpandablePanel extends HookConsumerWidget {
  const PlayerDetailHeaderExpandablePanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playerInferred = ref.watch(
      providers.players.select((_) => _.playerInferred),
    );
    final champions = ref.watch(
      providers.champions.select((_) => _.champions),
    );
    final playerChampions = ref.watch(
      providers.champions.select((_) => _.playerChampions),
    );

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final recentPartyMembers = playerInferred?.recentPartyMembers;
    final recentlyPlayedChampionIds =
        playerInferred?.recentlyPlayedChampions ?? [];

    // Hooks
    final recentlyPlayedChampions = useMemoized(
      () {
        return champions.where(
          (champion) => recentlyPlayedChampionIds.contains(champion.championId),
        );
      },
      [recentlyPlayedChampionIds],
    );
    final recentlyPlayedPlayerChampions = useMemoized(
      () {
        return recentlyPlayedChampionIds.map(
          (championId) => playerChampions?.firstWhere(
            (_) => _.championId == championId,
          ),
        );
      },
      [recentlyPlayedChampionIds],
    );

    return recentPartyMembers != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "RECENTLY PLAYED WITH",
                style: textTheme.headline1?.copyWith(
                  fontSize: 14,
                  color: textTheme.headline1?.color?.withOpacity(0.35),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: _RecentPartyMemberCard.itemHeight,
                child: ListView.separated(
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: recentPartyMembers.length,
                  itemBuilder: (_, index) {
                    final recentPartyMember =
                        recentPartyMembers.elementAt(index);

                    return _RecentPartyMemberCard(player: recentPartyMember);
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "RECENTLY PLAYED CHAMPION${recentlyPlayedChampions.length != 1 ? 'S' : ''}",
                style: textTheme.headline1?.copyWith(
                  fontSize: 14,
                  color: textTheme.headline1?.color?.withOpacity(0.35),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: _RecentlyPlayedChampionCard.itemHeight,
                child: ListView.separated(
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: recentlyPlayedChampions.length,
                  itemBuilder: (_, index) {
                    final recentlyPlayedChampion =
                        recentlyPlayedChampions.elementAt(
                      index,
                    );
                    final recentlyPlayedPlayerChampion =
                        recentlyPlayedPlayerChampions.elementAt(
                      index,
                    );

                    return _RecentlyPlayedChampionCard(
                      champion: recentlyPlayedChampion,
                      playerChampion: recentlyPlayedPlayerChampion,
                    );
                  },
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}
