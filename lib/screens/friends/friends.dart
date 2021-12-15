import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/friends/friends_list.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class Friends extends ConsumerStatefulWidget {
  static const routeName = '/friends';
  const Friends({Key? key}) : super(key: key);

  @override
  _PlayerDetailState createState() => _PlayerDetailState();
}

class _PlayerDetailState extends ConsumerState<Friends> {
  bool _init = true;
  bool _isLoading = true;
  final _friendsListKey = GlobalKey<AnimatedListState>();
  models.Player? selectedFriend;

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      final authProvider = ref.read(providers.auth);
      final playersProvider = ref.read(providers.players);

      _init = false;

      if (authProvider.player?.playerId != null) {
        playersProvider
            .getFriendsList(
          authProvider.player!.playerId,
          authProvider.user?.favouriteFriends,
        )
            .then((_) {
          setState(() => _isLoading = false);
        });
      }
    }
    super.didChangeDependencies();
  }

  onSelectFriend(models.Player friend) {
    if (selectedFriend?.playerId == friend.playerId) {
      return;
    }

    // get the playerStatus from the provider
    final playersProvider = ref.read(providers.players);
    setState(() => selectedFriend = friend);
    playersProvider.getPlayerStatus(friend.playerId);
  }

  onFavouriteFriend() async {
    final authProvider = ref.read(providers.auth);
    final playersProvider = ref.read(providers.players);

    final result =
        await authProvider.markFavouriteFriend(selectedFriend!.playerId);

    if (result == 2) {
      // user already has max number of friends
      // show a toast displaying this info

      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          elevation: 10,
          content: Text(
            "You cannot have more than ${utilities.Global.essentials!.maxFavouriteFriends} favourite friends",
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (result == 1) {
      // player is added in list
      playersProvider.moveFriendToTop(selectedFriend!.playerId);
      _friendsListKey.currentState?.insertItem(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Friends'),
      ),
      body: _isLoading
          ? const Center(
              child: widgets.LoadingIndicator(
                size: 36,
              ),
            )
          : FriendsList(
              friendsListKey: _friendsListKey,
              selectedFriend: selectedFriend,
              onFavouriteFriend: onFavouriteFriend,
              onSelectFriend: onSelectFriend,
            ),
    );
  }
}
