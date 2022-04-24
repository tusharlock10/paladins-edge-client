import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
  static const routeName = '/friends';
  final _friendsListKey = GlobalKey<AnimatedListState>();

  Friends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playersProvider = ref.read(providers.players);
    final authProvider = ref.read(providers.auth);
    final favouriteFriends =
        ref.watch(providers.auth.select((_) => _.user?.favouriteFriends));
    final playerId =
        ref.watch(providers.auth.select((_) => _.player?.playerId));
    final isLoadingFriends =
        ref.watch(providers.players.select((_) => _.isLoadingFriends));
    final friends = ref.watch(providers.players.select((_) => _.friends));

    // State
    final selectedFriend = useState<models.Player?>(null);

    // Effects
    useEffect(
      () {
        if (playerId != null && friends.isEmpty) {
          playersProvider.getFriendsList(
            playerId: playerId,
            favouriteFriends: favouriteFriends,
          );
        }

        return null;
      },
      [],
    );

    // Methods
    final onSelectFriend = useCallback(
      (models.Player friend) {
        if (selectedFriend.value?.playerId == friend.playerId) return;
        // get the playerStatus from the provider
        selectedFriend.value = friend;

        playersProvider.getPlayerStatus(playerId: friend.playerId);
      },
      [],
    );

    final onFavouriteFriend = useCallback(
      () async {
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
          playersProvider.moveFriendToTop(selectedFriend.value!.playerId);
          _friendsListKey.currentState?.insertItem(0);
        }
      },
      [],
    );

    final onRefresh = useCallback(
      () {
        if (playerId != null) {
          return playersProvider.getFriendsList(
            playerId: playerId,
            favouriteFriends: favouriteFriends,
            forceUpdate: true,
          );
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
                    selectedFriend: selectedFriend.value,
                    onFavouriteFriend: onFavouriteFriend,
                    onSelectFriend: onSelectFriend,
                  ),
          ],
        ),
      ),
    );
  }
}
