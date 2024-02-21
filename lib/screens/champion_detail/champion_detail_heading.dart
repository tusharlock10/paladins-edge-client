import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:intl/intl.dart";
import "package:jiffy/jiffy.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/gen/assets.gen.dart";
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class ChampionDetailHeading extends HookConsumerWidget {
  final models.Champion champion;
  const ChampionDetailHeading({
    required this.champion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final championsProvider = ref.read(providers.champions);
    final isGuest = ref.watch(providers.auth.select((_) => _.isGuest));
    final isLightTheme = ref.watch(
      providers.appState.select((_) => _.settings.themeMode == ThemeMode.light),
    );
    final favouriteChampions = ref.watch(
      providers.champions.select((_) => _.favouriteChampions),
    );

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final fireRate = champion.fireRate != 0 ? champion.fireRate : 1;
    final dps = (champion.weaponDamage ~/ fireRate).toString();
    final health = utilities.humanizeNumber(champion.health);
    final birthDay =
        Jiffy.parseFromDateTime(champion.releaseDate).format(pattern: "MMM do");

    // Hooks
    final championIcon = useMemoized(
      () {
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

    final range = useMemoized(
      () {
        if (champion.damageFallOffRange == 0) {
          return "Range ∞";
        } else if (champion.damageFallOffRange < 0) {
          return "Range ${champion.damageFallOffRange.abs().toInt()}";
        }

        return "Fall-off ${champion.damageFallOffRange.toInt()}";
      },
      [champion],
    );

    final isFavourite = useMemoized(
      () {
        return favouriteChampions.contains(champion.championId);
      },
      [favouriteChampions, champion],
    );

    // Methods
    final onPressFavourite = useCallback(
      () {
        championsProvider.markFavouriteChampion(champion.championId);
      },
      [champion],
    );

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Hero(
            tag: "${champion.championId}Icon",
            child: widgets.ElevatedAvatar(
              imageUrl: championIcon.imageUrl,
              imageBlurHash: championIcon.blurHash,
              isAssetImage: championIcon.isAssetImage,
              size: 42,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    champion.name.toUpperCase(),
                    style: textTheme.displayLarge?.copyWith(
                      fontSize: 24,
                    ),
                  ),
                  SelectableText(
                    champion.title.toUpperCase(),
                    style: textTheme.displayLarge?.copyWith(
                      color: isLightTheme
                          ? const Color.fromARGB(255, 88, 88, 88)
                          : const Color.fromARGB(210, 145, 203, 28),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "$dps DPS | $health Health | $range",
                    style: textTheme.bodyLarge?.copyWith(fontSize: 10),
                  ),
                  Text(
                    "B'day on $birthDay",
                    style: textTheme.bodyLarge?.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              champion.unlockCost == null
                  ? const SizedBox()
                  : champion.unlockCost == 0
                      ? Text(
                          "Free Unlock",
                          style: textTheme.bodyLarge?.copyWith(fontSize: 12),
                        )
                      : Row(
                          children: [
                            Assets.icons.gold.image(height: 15, width: 15),
                            const SizedBox(width: 2),
                            Text(
                              NumberFormat.decimalPattern().format(
                                champion.unlockCost,
                              ),
                              style: textTheme.displayLarge?.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
              const SizedBox(height: 10),
              if (!isGuest)
                widgets.FavouriteStar(
                  isFavourite: isFavourite,
                  onPress: onPressFavourite,
                  size: 28,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
