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
    // Variables
    final textTheme = Theme.of(context).textTheme;
    final isLightTheme = ref.watch(
      providers.auth.select((_) => _.settings.themeMode == ThemeMode.light),
    );
    final fireRate = champion.fireRate != 0 ? champion.fireRate : 1;
    final dps = (champion.weaponDamage ~/ fireRate).toString();
    final health = utilities.humanizeNumber(champion.health);
    final birthDay = Jiffy(champion.releaseDate).format("MMM do");
    String range = "";
    if (champion.damageFallOffRange == 0) {
      range = "Range ∞";
    } else if (champion.damageFallOffRange < 0) {
      range = "Range ${champion.damageFallOffRange.abs().toInt()}";
    } else {
      range = "Fall-off ${champion.damageFallOffRange.toInt()}";
    }

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
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          champion.name.toUpperCase(),
                          style: textTheme.headline1?.copyWith(
                            fontSize: 24,
                          ),
                        ),
                        champion.unlockCost == 0
                            ? Text(
                                "Free Unlock",
                                style:
                                    textTheme.bodyText1?.copyWith(fontSize: 12),
                              )
                            : Row(
                                children: [
                                  Assets.icons.gold
                                      .image(height: 15, width: 15),
                                  const SizedBox(width: 2),
                                  Text(
                                    NumberFormat.decimalPattern().format(
                                      champion.unlockCost,
                                    ),
                                    style: textTheme.headline1?.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                    Text(
                      champion.title.toUpperCase(),
                      style: textTheme.headline1?.copyWith(
                        color: isLightTheme
                            ? const Color.fromARGB(255, 88, 88, 88)
                            : const Color.fromARGB(210, 145, 203, 28),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "$dps DPS | $health Health | $range",
                      style: textTheme.bodyText1?.copyWith(fontSize: 10),
                    ),
                    Text(
                      "B'day on $birthDay",
                      style: textTheme.bodyText1?.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
