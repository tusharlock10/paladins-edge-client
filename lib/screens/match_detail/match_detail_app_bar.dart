import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class MatchDetailAppBar extends HookConsumerWidget {
  final data_classes.CombinedMatch? combinedMatch;
  const MatchDetailAppBar({
    required this.combinedMatch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final matchesProvider = ref.read(providers.matches);
    final isGuest = ref.watch(providers.auth.select((_) => _.isGuest));
    final savedMatches = ref.watch(
      providers.auth.select((_) => _.user?.savedMatchIds ?? []),
    );
    // Variables
    final match = combinedMatch?.match;
    final isSavedMatch = savedMatches.contains(match?.matchId);

    // Methods
    final guestLogin = useCallback(
      () {
        if (!isGuest) return;
        widgets.showLoginModal(
          data_classes.ShowLoginModalOptions(
            context: context,
            loginCta: constants.LoginCTA.savedMatches,
          ),
        );
      },
      [isGuest],
    );

    final onSaveMatch = useCallback(
      () async {
        if (match == null) return;
        if (isGuest) return guestLogin();

        final result = await matchesProvider.saveMatch(match.matchId);

        if (result == data_classes.SaveMatchResult.limitReached) {
          // user already has max number of savedMatches
          // show a toast displaying this info

          widgets.showToast(
            context: context,
            text:
                "You cannot have more than ${utilities.Global.essentials!.maxSavedMatches} saved matches",
            type: widgets.ToastType.info,
          );
        }
      },
      [match, isGuest],
    );

    return SliverAppBar(
      snap: true,
      floating: true,
      forceElevated: true,
      pinned: constants.isWeb,
      actions: [
        if (!(match?.isInComplete ?? true))
          IconButton(
            onPressed: onSaveMatch,
            icon: Icon(
              isSavedMatch ? Icons.bookmark : Icons.bookmark_outline,
              size: 22,
              semanticLabel: "Save Match",
            ),
          ),
      ],
      title: Column(
        children: [
          Text(
            match == null ? "Match" : match.queue,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (match != null)
            Text(
              match.matchId.toString(),
              style: const TextStyle(fontSize: 12),
            ),
        ],
      ),
    );
  }
}
