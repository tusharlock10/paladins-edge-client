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
    final authProvider = ref.read(providers.auth);
    final playersProvider = ref.read(providers.players);

    // State
    final isLoading = useState(true);
    final selectedFriend = useState<models.Player?>(null);

    // Effects
    useEffect(
      () {
        if (authProvider.player?.playerId != null) {
          playersProvider
              .getFriendsList(
                authProvider.player!.playerId,
                authProvider.user?.favouriteFriends,
              )
              .then((_) => isLoading.value = false);
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

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const FriendsAppBar(),
          FriendSelected(
            selectedFriend: selectedFriend.value,
            onFavouriteFriend: onFavouriteFriend,
          ),
          isLoading.value
              ? SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      SizedBox(
                        height: utilities.getBodyHeight(context),
                        child: const Center(
                          child: widgets.LoadingIndicator(
                            size: 36,
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
    );
  }
}
