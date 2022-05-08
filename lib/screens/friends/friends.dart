import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/friends/friend_selected.dart';
import 'package:paladinsedge/screens/friends/friends_app_bar.dart';
import 'package:paladinsedge/screens/friends/friends_list.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class Friends extends HookConsumerWidget {
  static const routeName = 'friends';
  static const routePath = 'friends';
  static final goRoute = GoRoute(
    name: routeName,
    path: routePath,
    builder: _routeBuilder,
  );

  final _friendsListKey = GlobalKey<AnimatedListState>();

  Friends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playersProvider = ref.read(providers.players);
    final friendsProvider = ref.read(providers.friends);
    final authProvider = ref.read(providers.auth);
    final playerId =
        ref.watch(providers.auth.select((_) => _.player?.playerId));
    final otherPlayer =
        ref.watch(providers.friends.select((_) => _.otherPlayer));
    final fetchedOtherPlayerId =
        ref.watch(providers.friends.select((_) => _.fetchedOtherPlayerId));
    final isLoadingFriends =
        ref.watch(providers.friends.select((_) => _.isLoadingFriends));
    final fetchedAllFriends =
        ref.watch(providers.friends.select((_) => _.fetchedAllFriends));

    // Variables
    final isOtherPlayer = otherPlayer != null;

    // State
    final selectedFriend = useState<models.Player?>(null);

    // Effects
    useEffect(
      () {
        if (isOtherPlayer) {
          // check if the previously fetched otherPlayer
          // is the same as this otherPlayer
          // do not fetch if they are the same
          if (otherPlayer?.playerId != fetchedOtherPlayerId) {
            friendsProvider.getOtherFriends();
          }
        } else if (playerId != null && !fetchedAllFriends) {
          friendsProvider.getUserFriends();
        }

        return isOtherPlayer ? friendsProvider.resetOtherPlayer : null;
      },
      [otherPlayer, playerId, fetchedAllFriends],
    );

    // Methods
    final onSelectFriend = useCallback(
      (models.Player friend) {
        if (isOtherPlayer) return;

        if (selectedFriend.value?.playerId == friend.playerId) return;
        // get the playerStatus from the provider
        selectedFriend.value = friend;

        playersProvider.getPlayerStatus(playerId: friend.playerId);
      },
      [],
    );

    final onFavouriteFriend = useCallback(
      () async {
        if (isOtherPlayer) return;
        if (selectedFriend.value == null) return;

        final result = await authProvider
            .markFavouriteFriend(selectedFriend.value!.playerId);

        if (result == data_classes.FavouriteFriendResult.limitReached) {
          // user already has max number of friends
          // show a toast displaying this info

          widgets.showToast(
            context: context,
            text:
                "You cannot have more than ${utilities.Global.essentials!.maxFavouriteFriends} favourite friends",
            type: widgets.ToastType.info,
          );
        } else if (result == data_classes.FavouriteFriendResult.added) {
          // player is added in list
          friendsProvider.moveFriendToTop(selectedFriend.value!.playerId);
          _friendsListKey.currentState?.insertItem(0);
        }
      },
      [],
    );

    final onRefresh = useCallback(
      () {
        if (isOtherPlayer) {
          friendsProvider.getOtherFriends(true);
        } else if (playerId != null) {
          friendsProvider.getUserFriends(true);
        }

        return Future.value(null);
      },
      [],
    );

    return Scaffold(
      body: widgets.Refresh(
        onRefresh: onRefresh,
        edgeOffset: utilities.getTopEdgeOffset(context),
        child: CustomScrollView(
          slivers: [
            const FriendsAppBar(),
            FriendSelected(
              selectedFriend: selectedFriend.value,
              onFavouriteFriend: onFavouriteFriend,
            ),
            isLoadingFriends
                ? SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        SizedBox(
                          height: utilities.getBodyHeight(context),
                          child: const Center(
                            child: widgets.LoadingIndicator(
                              lineWidth: 2,
                              size: 28,
                              label: Text('Getting friends'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : FriendsList(
                    friendsListKey: _friendsListKey,
                    onSelectFriend: onSelectFriend,
                  ),
          ],
        ),
      ),
    );
  }

  static Friends _routeBuilder(_, __) => Friends();
}
