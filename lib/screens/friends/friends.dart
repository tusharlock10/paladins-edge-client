import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
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
      },
      [],
    );

    // Methods
    final onSelectFriend = useCallback(
      (models.Player friend) {
        if (selectedFriend.value?.playerId == friend.playerId) return;
        // get the playerStatus from the provider
        selectedFriend.value = friend;

        playersProvider.getPlayerStatus(friend.playerId);
      },
      [],
    );

    final onFavouriteFriend = useCallback(
      () async {
        if (selectedFriend.value == null) return;

        final result = await authProvider
            .markFavouriteFriend(selectedFriend.value!.playerId);

        // TODO: Change result to be an enum
        if (result == 2) {
          // user already has max number of friends
          // show a toast displaying this info

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              elevation: 10,
              content: Text(
                "You cannot have more than ${utilities.Global.essentials!.maxFavouriteFriends} favourite friends",
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else if (result == 1) {
          // player is added in list
          playersProvider.moveFriendToTop(selectedFriend.value!.playerId);
          _friendsListKey.currentState?.insertItem(0);
        }
      },
      [],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Friends'),
      ),
      body: isLoading.value
          ? const Center(
              child: widgets.LoadingIndicator(
                size: 36,
              ),
            )
          : FriendsList(
              friendsListKey: _friendsListKey,
              selectedFriend: selectedFriend.value,
              onFavouriteFriend: onFavouriteFriend,
              onSelectFriend: onSelectFriend,
            ),
    );
  }
}
