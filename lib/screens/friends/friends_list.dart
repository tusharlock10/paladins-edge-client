import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/friends/friend_item.dart';

class FriendsList extends ConsumerWidget {
  final GlobalKey<AnimatedListState> friendsListKey;
  final models.Player? selectedFriend;
  final void Function() onFavouriteFriend;
  final void Function(models.Player) onSelectFriend;

  const FriendsList({
    required this.friendsListKey,
    required this.selectedFriend,
    required this.onFavouriteFriend,
    required this.onSelectFriend,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friends = ref.watch(providers.players.select((_) => _.friends));

    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      sliver: SliverAnimatedList(
        key: friendsListKey,
        initialItemCount: friends.length,
        itemBuilder: (context, index, animation) {
          final friend = friends[index];

          return SlideTransition(
            position: animation.drive(
              Tween<Offset>(
                begin: const Offset(1, 0),
                end: const Offset(0, 0),
              ),
            ),
            child: FriendItem(
              friend: friend,
              onSelectFriend: onSelectFriend,
            ),
          );
        },
      ),
    );
  }
}
