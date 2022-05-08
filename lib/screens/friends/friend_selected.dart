import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/friends/friend_active_match.dart';
import 'package:paladinsedge/screens/friends/friend_status_indicator.dart';
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class FriendSelected extends HookConsumerWidget {
  final models.Player? selectedFriend;
  final void Function() onFavouriteFriend;

  const FriendSelected({
    required this.selectedFriend,
    required this.onFavouriteFriend,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
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

        context.goNamed(
          screens.PlayerDetail.routeName,
          params: {
            'playerId': selectedFriend!.playerId,
          },
        );
      },
      [selectedFriend],
    );

    return SliverPadding(
      padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
      sliver: SliverToBoxAdapter(
        child: selectedFriend != null
            ? Column(
                children: [
                  Card(
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
                                      style:
                                          theme.textTheme.headline3?.copyWith(
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
                                        ? FriendStatusIndicator(
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
                          FriendActiveMatch(match: playerStatus?.match),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                ],
              )
            : const SizedBox(),
      ),
    );
  }
}
