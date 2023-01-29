import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/api/index.dart" as api;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/auth.dart" as auth_provider;
import "package:paladinsedge/utilities/index.dart" as utilities;

class _FriendsNotifier extends ChangeNotifier {
  final ChangeNotifierProviderRef<_FriendsNotifier> ref;
  bool isLoadingFriends = false;
  bool isLoadingFavouriteFriends = true;

  /// Is true when we have fetched all the friends
  /// becomes true, when we visit Friends screen
  bool fetchedAllFriends = false;

  /// List of friends for user's player
  List<models.Player>? friends;

  /// List of friends of otherPlayer
  List<models.Player>? otherPlayerFriends;

  _FriendsNotifier({required this.ref});

  Future<void> getUserFriends([bool forceUpdate = false]) async {
    final playerId = ref.read(auth_provider.auth).player?.playerId;
    final favouriteFriends =
        ref.read(auth_provider.auth).user?.favouriteFriendIds;
    if (playerId == null) return;

    if (!forceUpdate) {
      isLoadingFriends = true;
      utilities.postFrameCallback(notifyListeners);
    }

    final response = await api.PlayersRequests.friends(playerId: playerId);
    if (response == null) {
      isLoadingFriends = false;
      notifyListeners();

      return;
    }

    if (!forceUpdate) isLoadingFriends = false;
    final friends = response.friends;

    if (favouriteFriends != null) {
      // sort the friends on the basis on name
      friends.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );

      // find favourite friends
      final favouritePlayers = List<models.Player>.empty(growable: true);
      friends.removeWhere((friend) {
        if (favouriteFriends.contains(friend.playerId)) {
          favouritePlayers.add(friend);

          return true;
        }

        return false;
      });

      this.friends = favouritePlayers + friends;
    }

    fetchedAllFriends = true;

    notifyListeners();
  }

  Future<void> getOtherFriends(
    int playerId, [
    bool forceUpdate = false,
  ]) async {
    if (!forceUpdate) {
      isLoadingFriends = true;
      utilities.postFrameCallback(notifyListeners);
    }

    final response = await api.PlayersRequests.friends(playerId: playerId);
    if (response == null) {
      isLoadingFriends = false;
      notifyListeners();

      return;
    }

    if (!forceUpdate) isLoadingFriends = false;
    otherPlayerFriends = response.friends;

    notifyListeners();
  }

  Future<void> getFavouriteFriends([bool forceUpdate = false]) async {
    if (!forceUpdate) {
      isLoadingFavouriteFriends = true;
      utilities.postFrameCallback(notifyListeners);
    }

    final response = await api.PlayersRequests.favouriteFriends();

    if (!response.success) {
      if (!forceUpdate) {
        isLoadingFavouriteFriends = false;
        notifyListeners();
      }

      return;
    }

    final favouriteFriends = response.data!;
    final friends = this.friends ?? [];
    final favouriteFriendIds = favouriteFriends.map((_) => _.playerId).toList();

    // find favourite players
    friends.removeWhere(
      (friend) => favouriteFriendIds.contains(friend.playerId),
    );

    this.friends = response.data! + friends;

    final user = ref.read(auth_provider.auth).user;
    user!.favouriteFriendIds = favouriteFriends.map((_) => _.playerId).toList();
    utilities.Database.saveUser(user);

    if (!forceUpdate) isLoadingFavouriteFriends = false;
    notifyListeners();
  }

  /// Clears all user sensitive data upon logout
  void clearData() {
    isLoadingFriends = false;
    isLoadingFavouriteFriends = false;
    fetchedAllFriends = false;
    friends = [];
  }
}

/// Provider to handle friends
final friends = ChangeNotifierProvider((ref) => _FriendsNotifier(ref: ref));
