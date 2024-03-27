import "package:flutter/material.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;

class PlayerStatsCard extends StatelessWidget {
  static const itemHeight = 56.0;
  static const itemWidth = 120.0;
  final String title;
  final num stat;
  final String? statString;
  final Color? color;
  const PlayerStatsCard({
    required this.title,
    required this.stat,
    this.statString,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textTheme = Theme.of(context).textTheme;
    String formattedStat = statString ??
        (stat < 10000
            ? stat.toStringAsPrecision(stat.toInt().toString().length + 1)
            : utilities.humanizeNumber(stat));

    if (num.tryParse(formattedStat)?.toInt() == stat) {
      formattedStat = stat.toInt().toString();
    }

    return SizedBox(
      width: itemWidth,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(isLightTheme ? 0.75 : 0.25),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 3),
            Text(
              formattedStat,
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge?.copyWith(color: color, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
