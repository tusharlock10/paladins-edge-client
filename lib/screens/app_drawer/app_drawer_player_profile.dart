import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class AppDrawerPlayerProfile extends HookConsumerWidget {
  const AppDrawerPlayerProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final player = ref.watch(providers.auth.select((_) => _.player));

    // Variables
    final textTheme = Theme.of(context).textTheme;

    // Methods
    final onTapPlayer = useCallback(
      () {
        if (player == null) return;

        utilities.Navigation.navigate(
          context,
          screens.PlayerDetail.routeName,
          params: {
            "playerId": player.playerId.toString(),
          },
        );
      },
      [],
    );

    if (player == null) {
      return const SizedBox();
    }

    return GestureDetector(
      onTap: onTapPlayer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widgets.ElevatedAvatar(
            imageUrl: player.avatarUrl,
            imageBlurHash: player.avatarBlurHash,
            size: 18,
            borderRadius: 0,
            elevation: 5,
          ),
          const SizedBox(width: 7),
          Column(
            children: [
              Text(
                player.name,
                style: textTheme.headline1?.copyWith(
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              ),
              player.title != null
                  ? Text(
                      player.title!,
                      style: textTheme.bodyText1?.copyWith(fontSize: 12),
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
