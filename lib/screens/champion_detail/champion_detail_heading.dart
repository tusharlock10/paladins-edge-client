import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class ChampionDetailHeading extends ConsumerWidget {
  final models.Champion champion;
  const ChampionDetailHeading({
    required this.champion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final isLightTheme = ref.watch(
      providers.auth.select((_) => _.settings.themeMode == ThemeMode.light),
    );

    final fireRate = champion.fireRate != 0 ? champion.fireRate : 1;
    final dps = (champion.weaponDamage ~/ fireRate).toString();
    final health = NumberFormat.compact().format(champion.health).toString();
    String range = '';

    if (champion.damageFallOffRange == 0) {
      range = 'Range ∞';
    } else if (champion.damageFallOffRange < 0) {
      range = 'Range ${champion.damageFallOffRange.abs().toInt()}';
    } else {
      range = 'Fall-off ${champion.damageFallOffRange.toInt()}';
    }

    final birthDay = Jiffy(champion.releaseDate).format('MMM do');

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Hero(
            tag: '${champion.championId}Icon',
            child: widgets.ElevatedAvatar(
              imageUrl: champion.iconUrl,
              imageBlurHash: champion.iconBlurHash,
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
                    Text(
                      champion.name.toUpperCase(),
                      style: textTheme.headline1?.copyWith(
                        fontSize: 24,
                      ),
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
                      '$dps DPS | $health Health | $range',
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
