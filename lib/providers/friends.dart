import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/api/index.dart" as api;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;

class _FriendsNotifier extends ChangeNotifier {
  final String? playerId;
  bool isLoadingFriends = false;
  List<models.Player>? friends;

  _FriendsNotifier({required this.playerId});

  Future<void> getFriends([bool forceUpdate = false]) async {
    if (playerId == null) return;
    if (!forceUpdate && friends != null) return;

    if (!forceUpdate) {
      isLoadingFriends = true;
      utilities.postFrameCallback(notifyListeners);
    }

    final response = await api.PlayersRequests.friends(playerId: playerId!);
    if (response == null) {
      isLoadingFriends = false;
      notifyListeners();

      return;
    }

    if (!forceUpdate) isLoadingFriends = false;
    friends = response.friends;
    friends?.sort((a, b) => a.name.compareTo(b.name));

    notifyListeners();
  }
}

/// Provider to handle friends
final friends = ChangeNotifierProvider.family<_FriendsNotifier, String?>(
  (_, playerId) => _FriendsNotifier(playerId: playerId),
);
