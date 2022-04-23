import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;

class MatchDetailAppBar extends ConsumerWidget {
  const MatchDetailAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final matchDetails =
        ref.watch(providers.matches.select((_) => _.matchDetails));

    // Variables
    final match = matchDetails?.match;

    return SliverAppBar(
      snap: true,
      floating: true,
      forceElevated: true,
      title: Column(
        children: [
          Text(
            match == null ? 'Match' : match.queue,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (match != null)
            Text(
              match.matchId,
              style: const TextStyle(fontSize: 12),
            ),
        ],
      ),
    );
  }
}
