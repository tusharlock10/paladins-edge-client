import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/auth.dart' as auth_provider;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class _FriendsNotifier extends ChangeNotifier {
  final ChangeNotifierProviderRef<_FriendsNotifier> ref;
  bool isLoadingFriends = false;
  bool isLoadingFavouriteFriends = false;

  /// Is true when we have fetched all the friends
  /// becomes true, when we visit Friends screen
  bool fetchedAllFriends = false;

  /// List of friends for user's player
  List<models.Player>? friends;

  /// The non-user player whose friends we want to show
  models.Player? otherPlayer;

  /// id of otherPlayer whose friends are stored in otherPlayerFriends
  /// when player goes back from Friends screen, otherPlayer is reset
  /// but otherPlayerFriends and fetchedOtherPlayerId is not reset
  /// this acts as a cache, when the user goes back and immediately visits
  /// the Friends screen of this player again, otherPlayerFriends will be shown
  /// instead of fetching it again from BE
  String? fetchedOtherPlayerId;

  /// List of friends of otherPlayer
  List<models.Player>? otherPlayerFriends;

  _FriendsNotifier({required this.ref});

  void moveFriendToTop(String playerId) {
    if (friends == null) return;
    final _friends = friends!;
    // the player to move to top of the friends list
    final player =
        _friends.firstOrNullWhere((friend) => friend.playerId == playerId);

    if (player == null) return;

    _friends.removeWhere((friend) => friend.playerId == playerId);
    _friends.insert(0, player);
    friends = _friends;

    notifyListeners();
  }

  Future<void> getUserFriends([bool forceUpdate = false]) async {
    final playerId = ref.read(auth_provider.auth).player?.playerId;
    final favouriteFriends =
        ref.read(auth_provider.auth).user?.favouriteFriends;
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
    final _friends = response.friends;

    if (favouriteFriends != null) {
      // sort the friends on the basis on name
      _friends.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );

      // find favourite friends
      final favouritePlayers = List<models.Player>.empty(growable: true);
      _friends.removeWhere((friend) {
        if (favouriteFriends.contains(friend.playerId)) {
          favouritePlayers.add(friend);

          return true;
        }

        return false;
      });

      friends = favouritePlayers + _friends;
    }

    fetchedAllFriends = true;

    notifyListeners();
  }

  void setOtherPlayer(models.Player player) {
    otherPlayer = player;
  }

  void resetOtherPlayer() {
    otherPlayer = null;
  }

  Future<void> getOtherFriends([bool forceUpdate = false]) async {
    final playerId = otherPlayer?.playerId;
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
    otherPlayerFriends = response.friends;
    fetchedOtherPlayerId = playerId;

    notifyListeners();
  }

  Future<void> getFavouriteFriends([bool forceUpdate = false]) async {
    if (!forceUpdate) {
      isLoadingFavouriteFriends = true;
      utilities.postFrameCallback(notifyListeners);
    }

    final response = await api.PlayersRequests.favouriteFriends();

    if (response == null) {
      if (!forceUpdate) {
        isLoadingFavouriteFriends = false;
        notifyListeners();
      }

      return;
    }

    final _friends = friends ?? [];
    final favouriteFriendsFromApi =
        response.favouriteFriends.map((_) => _.playerId).toList();

    // find favourite players
    _friends.removeWhere(
      (friend) => favouriteFriendsFromApi.contains(friend.playerId),
    );

    friends = response.favouriteFriends + _friends;

    final user = ref.read(auth_provider.auth).user;
    user!.favouriteFriends =
        response.favouriteFriends.map((_) => _.playerId).toList();
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
