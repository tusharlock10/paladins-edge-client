import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paladinsedge/providers/index.dart' as providers;

class MatchStats extends HookConsumerWidget {
  const MatchStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final matchDetails =
        ref.watch(providers.matches.select((_) => _.matchDetails));

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final match = matchDetails?.match;
    if (match == null) return const SizedBox.shrink();
    final matchDuration = printDuration(
      Duration(seconds: match.matchDuration),
      abbreviated: true,
      upperTersity: DurationTersity.minute,
      conjugation: ' ',
    ).replaceAll("min", "m");
    final map = match.map.split(" ").sublist(1).join(" ");
    final region = match.region;
    final date =
        Jiffy(match.matchStartTime.toLocal()).format("do MMMM, h:mm a");

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                region,
                style: textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                matchDuration,
                style:
                    textTheme.bodyText1?.copyWith(fontStyle: FontStyle.italic),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                map,
                style: textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                date.toString(),
                style:
                    textTheme.bodyText1?.copyWith(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
