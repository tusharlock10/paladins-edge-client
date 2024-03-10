import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/friends/friend_item.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;

class FriendsList extends ConsumerWidget {
  final String? playerId;
  final bool isOtherPlayer;

  const FriendsList({
    required this.playerId,
    required this.isOtherPlayer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final friendNotifier = providers.friends(playerId);
    final friends = ref.watch(friendNotifier.select((_) => _.friends));

    // Variables
    int crossAxisCount;
    double horizontalPadding;
    double width;
    final size = MediaQuery.of(context).size;
    if (size.height < size.width) {
      // for landscape mode
      crossAxisCount = 2;
      width = size.width * 0.75;
      horizontalPadding = (size.width - width) / 2;
    } else {
      // for portrait mode
      crossAxisCount = 1;
      width = size.width;
      horizontalPadding = 15;
    }
    final itemWidth = width / crossAxisCount;
    double childAspectRatio = itemWidth / FriendItem.itemHeight;

    return friends == null
        ? SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                SizedBox(
                  height: utilities.getBodyHeight(context),
                  child: Center(
                    child: Center(
                      child: Text(
                        isOtherPlayer
                            ? "Sorry we were unable to fetch friends of this player"
                            : "Sorry we were unable to fetch your friends",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: horizontalPadding,
            ),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
              ),
              delegate: SliverChildBuilderDelegate(
                (_, index) => FriendItem(
                  isOtherPlayer: isOtherPlayer,
                  friend: friends[index],
                ),
                childCount: friends.length,
              ),
            ),
          );
  }
}
