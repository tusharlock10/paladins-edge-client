import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/friends/active_match_card.dart';
import 'package:paladinsedge/screens/friends/status_indicator.dart';
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class SelectedFriend extends HookConsumerWidget {
  final models.Player? selectedFriend;
  final void Function() onFavouriteFriend;

  const SelectedFriend({
    required this.selectedFriend,
    required this.onFavouriteFriend,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playersProvider = ref.read(providers.players);
    final playerStatus =
        ref.watch(providers.players.select((_) => _.playerStatus));
    final favouriteFriends =
        ref.watch(providers.auth.select((_) => _.user?.favouriteFriends));

    // Variables
    final theme = Theme.of(context);
    final bool isFavourite =
        favouriteFriends?.contains(selectedFriend?.playerId) ?? false;

    // Methods
    final onPressFriend = useCallback(
      () {
        if (selectedFriend == null) return;

        playersProvider.setPlayerId(selectedFriend!.playerId);
        Navigator.of(context).pushNamed(screens.PlayerDetail.routeName);
      },
      [selectedFriend],
    );

    return Column(
      children: [
        selectedFriend != null
            ? Card(
                elevation: 7,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: onPressFriend,
                                child: Text(
                                  selectedFriend!.name,
                                  style: theme.textTheme.headline3?.copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              Text(
                                'Level ${selectedFriend!.level}',
                                style: theme.textTheme.bodyText2,
                              ),
                              Text(
                                selectedFriend!.platform,
                                style: theme.textTheme.bodyText1,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                widgets.Ripple(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  onTap: onFavouriteFriend,
                                  child: Icon(
                                    isFavourite
                                        ? Icons.star
                                        : Icons.star_outline_outlined,
                                    size: 20,
                                    color: isFavourite
                                        ? Colors.yellow
                                        : theme.textTheme.bodyText1?.color,
                                  ),
                                ),
                                playerStatus != null
                                    ? StatusIndicator(
                                        status: playerStatus.status,
                                      )
                                    : const widgets.LoadingIndicator(
                                        size: 16,
                                        lineWidth: 1.5,
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ActiveMatchCard(match: playerStatus?.match),
                    ],
                  ),
                ),
              )
            : Column(
                children: const [
                  Text('* Select a friend to know his online status'),
                  Text('* Slide the friend card left to mark favourite'),
                ],
              ),
        const SizedBox(height: 10),
        const Divider(
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }
}
