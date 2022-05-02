import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class PlayerDetailHeader extends HookConsumerWidget {
  const PlayerDetailHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playersProvider = ref.read(providers.players);
    final friendsProvider = ref.read(providers.friends);
    final player = ref.watch(providers.players.select((_) => _.playerData));

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    // Methods
    final onPressActiveMatch = useCallback(
      () {
        if (player == null) return;

        playersProvider.setPlayerStatusPlayerId(player.playerId);
        Navigator.of(context).pushNamed(screens.ActiveMatch.routeName);
      },
      [],
    );

    final onPressFriends = useCallback(
      () {
        if (player == null) return;

        // set otherPlayerId
        friendsProvider.setOtherPlayer(player);
        Navigator.of(context).pushNamed(screens.Friends.routeName);
      },
      [],
    );

    return player == null
        ? const SizedBox()
        : IntrinsicHeight(
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 12.5,
                  sigmaY: 12.5,
                  tileMode: TileMode.mirror,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: scaffoldBackgroundColor.withOpacity(0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            widgets.ElevatedAvatar(
                              imageUrl: player.avatarUrl,
                              imageBlurHash: player.avatarBlurHash,
                              size: 42,
                              borderRadius: 10,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    widgets.FastImage(
                                      imageUrl: player.ranked.rankIconUrl,
                                      imageBlurHash:
                                          player.ranked.rankIconBlurHash,
                                      height: 36,
                                      width: 36,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          player.ranked.rankName,
                                          style: textTheme.bodyText2
                                              ?.copyWith(fontSize: 14),
                                        ),
                                        Text(
                                          '${player.ranked.points} TP',
                                          style: textTheme.bodyText1
                                              ?.copyWith(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    widgets.Button(
                                      label: 'Friends',
                                      color: Colors.green,
                                      onPressed: onPressFriends,
                                    ),
                                    const SizedBox(width: 10),
                                    widgets.Button(
                                      label: 'Active Match',
                                      onPressed: onPressActiveMatch,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
