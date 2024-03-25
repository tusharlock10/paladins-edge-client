import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/widgets/index.dart" as widgets;

class HomePlayerTimedStats extends HookConsumerWidget {
  final String playerId;

  const HomePlayerTimedStats({
    required this.playerId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playerNotifier = providers.players(playerId);
    final playerProvider = ref.read(playerNotifier);
    final timedStats = ref.watch(playerNotifier.select((_) => _.timedStats));
    final isPlayerMatchesLoading =
        ref.watch(playerNotifier.select((_) => _.isPlayerMatchesLoading));

    // Effects
    useEffect(
      () {
        playerProvider.getPlayerMatches();

        return null;
      },
      [],
    );

    return timedStats == null || isPlayerMatchesLoading
        ? const widgets.LoadingIndicator(size: 18)
        : Card(
            child: Text("Average Kills : ${timedStats.averageStats.kills}"),
          );
  }
}
