import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/match_detail/match_detail_list.dart';

class MatchDetail extends HookConsumerWidget {
  static const routeName = '/matchDetail';

  const MatchDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final matchDetails =
        ref.watch(providers.matches.select((_) => _.matchDetails));

    // Variables
    final match = matchDetails?.match;

    return Scaffold(
      appBar: AppBar(
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
      ),
      body: const MatchDetailList(),
    );
  }
}
