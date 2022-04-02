import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/match_detail/match_detail_list.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:url_launcher/url_launcher.dart';

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

    // Methods
    final onPressLink = useCallback(
      () {
        if (matchDetails?.match != null) {
          final matchId = matchDetails!.match.matchId;
          launch(constants.PaladinsGuruSite.match(matchId));
        }
      },
      [matchDetails?.match.matchId],
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: TouchableOpacity(
              onTap: onPressLink,
              child: const Icon(
                FeatherIcons.externalLink,
              ),
            ),
          ),
        ],
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
