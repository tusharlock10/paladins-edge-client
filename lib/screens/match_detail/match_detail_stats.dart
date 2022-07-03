import "package:duration/duration.dart";
import "package:flutter/material.dart";
import "package:jiffy/jiffy.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;

class MatchDetailStats extends StatelessWidget {
  final data_classes.CombinedMatch? combinedMatch;
  const MatchDetailStats({
    required this.combinedMatch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;
    final match = combinedMatch?.match;
    if (match == null) return const SizedBox.shrink();
    final matchDuration = printDuration(
      Duration(seconds: match.matchDuration),
      abbreviated: true,
      upperTersity: DurationTersity.minute,
      conjugation: " ",
    ).replaceAll("min", "m");
    final map = match.map.split(" ").sublist(1).join(" ");
    final region = match.region;
    final date = Jiffy(
      match.matchStartTime.toLocal(),
    ).format("do MMMM, h:mm a");

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    region,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    matchDuration,
                    style: textTheme.bodyText1
                        ?.copyWith(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    map,
                    textAlign: TextAlign.end,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    date.toString(),
                    style: textTheme.bodyText1
                        ?.copyWith(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
