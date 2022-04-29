import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/friends/friend_item.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;

class FriendsList extends ConsumerWidget {
  final GlobalKey<AnimatedListState> friendsListKey;
  final void Function(models.Player) onSelectFriend;

  const FriendsList({
    required this.friendsListKey,
    required this.onSelectFriend,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final otherPlayer =
        ref.watch(providers.friends.select((_) => _.otherPlayer));
    final friends = ref.watch(providers.friends.select((_) => _.friends));
    final otherPlayerFriends =
        ref.watch(providers.friends.select((_) => _.otherPlayerFriends));

    // Variables
    final isOtherPlayer = otherPlayer != null;
    final data = isOtherPlayer ? otherPlayerFriends : friends;

    return data == null
        ? SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                SizedBox(
                  height: utilities.getBodyHeight(context),
                  child: Center(
                    child: Center(
                      child: Text(
                        isOtherPlayer
                            ? 'Sorry we were unable to fetch friends of this player'
                            : 'Sorry we were unable to fetch your friends',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            sliver: SliverAnimatedList(
              key: friendsListKey,
              initialItemCount: data.length,
              itemBuilder: (context, index, animation) {
                final friend = data[index];

                return SlideTransition(
                  position: animation.drive(
                    Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: const Offset(0, 0),
                    ),
                  ),
                  child: FriendItem(
                    friend: friend,
                    onSelectFriend:
                        isOtherPlayer ? null : () => onSelectFriend(friend),
                  ),
                );
              },
            ),
          );
  }
}
