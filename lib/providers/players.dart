import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/auth.dart' as auth_provider;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class _PlayersNotifier extends ChangeNotifier {
  bool isLoadingPlayerData = false;
  bool isLoadingPlayerStatus = false;
  bool isLoadingFriends = false;
  bool isLoadingFavouriteFriends = false;
  bool fetchedAllFriends = false;
  String? playerId;
  String? playerStatusPlayerId;
  models.Player? playerData;
  api.PlayerStatusResponse? playerStatus;
  List<api.LowerSearch> lowerSearchList = [];
  List<models.Player>? friends;
  List<models.Player> topSearchList = [];
  List<models.SearchHistory> searchHistory = [];
  final ChangeNotifierProviderRef<_PlayersNotifier> ref;

  _PlayersNotifier({required this.ref});

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

  Future<void> getFriends({
    required String playerId,
    required List<String>? favouriteFriends,
    bool forceUpdate = false,
  }) async {
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
      final favouritePlayers = List<models.Player>.empty();
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

  Future<void> getPlayerStatus({
    required String playerId,
    bool forceUpdate = false,
  }) async {
    if (!forceUpdate) {
      isLoadingPlayerStatus = true;
      utilities.postFrameCallback(notifyListeners);
    }

    playerStatus = await api.PlayersRequests.playerStatus(playerId: playerId);

    if (!forceUpdate) isLoadingPlayerStatus = false;
    notifyListeners();
  }

  /// Loads the `searchHistory` data for the user from local db and
  /// syncs it with server for showing in Search screen
  void loadSearchHistory() async {
    // gets the search history from local db
    final _searchHistory = utilities.Database.getSearchHistory();

    // if searchHistory is not available
    // fetch it from backend
    if (_searchHistory == null) {
      final response = await api.PlayersRequests.searchHistory();

      if (response == null) {
        searchHistory = [];

        return;
      }

      searchHistory = response.searchHistory;
      response.searchHistory.forEach(utilities.Database.saveSearchHistory);
    } else {
      searchHistory = _searchHistory;
    }

    // remove searchHistory older than 7 days
    searchHistory = searchHistory
        .where(
          (searchItem) =>
              DateTime.now().difference(searchItem.time) <
              const Duration(days: 7),
        )
        .toList();

    // sort search history on basis of time
    searchHistory.sort((a, b) => b.time.compareTo(a.time));

    utilities.postFrameCallback(notifyListeners);
  }

  Future<void> insertSearchHistory({
    required String playerName,
    required String playerId,
  }) async {
    // remove existing searchItem
    final index = searchHistory.indexWhere((_) => _.playerId == playerId);
    if (index != -1) searchHistory.removeAt(index);

    final searchItem = models.SearchHistory(
      playerName: playerName,
      playerId: playerId,
      time: DateTime.now(),
    );

    searchHistory.insert(0, searchItem);

    // remove all entries from searchBox and reinsert entries
    await utilities.Database.searchHistoryBox?.clear();
    searchHistory.forEach(utilities.Database.saveSearchHistory);
  }

  Future<bool> searchByName({
    required String playerName,
    required bool simpleResults,
    required bool addInSearchHistory,
  }) async {
    // makes a req. to api for search
    // saves the searchItem in the searchHistory
    // saves the searchItem in the local db

    final response = await api.PlayersRequests.searchPlayers(
      playerName: playerName,
      simpleResults: simpleResults,
    );

    if (response == null) {
      // return false when api call is not successful
      return false;
    }

    if (response.exactMatch) {
      playerId = response.playerData!.playerId;
      playerData = response.playerData;

      if (addInSearchHistory) {
        await insertSearchHistory(
          playerName: playerData!.name,
          playerId: playerId!,
        );
      }
    } else {
      topSearchList = response.searchData.topSearchList;
      lowerSearchList = response.searchData.lowerSearchList;
    }

    notifyListeners();

    return response.exactMatch;
  }

  void clearSearchList() {
    topSearchList = [];
    lowerSearchList = [];
    notifyListeners();
  }

  /// The the playerId of the player to be shown in profile detail screen
  void setPlayerId(String _playerId) {
    playerData = null;
    playerId = _playerId;

    notifyListeners();
  }

  /// The the playerId of the player to be shown in active match screen
  void setPlayerStatusPlayerId(String _playerStatusPlayerId) {
    playerStatus = null;
    playerStatusPlayerId = _playerStatusPlayerId;

    notifyListeners();
  }

  void getPlayerData({
    required bool forceUpdate,
  }) async {
    if (playerId == null) return;

    isLoadingPlayerData = true;
    utilities.postFrameCallback(notifyListeners);

    final response = await api.PlayersRequests.playerDetail(
      playerId: playerId!,
      forceUpdate: forceUpdate,
    );

    if (response == null) {
      isLoadingPlayerData = false;
      notifyListeners();

      return null;
    }

    playerData = response.player;

    await insertSearchHistory(
      playerName: playerData!.name,
      playerId: playerId!,
    );

    isLoadingPlayerData = false;
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
    isLoadingPlayerData = false;
    isLoadingPlayerStatus = false;
    isLoadingFriends = false;
    isLoadingFavouriteFriends = false;
    fetchedAllFriends = false;
    playerId = null;
    playerStatusPlayerId = null;
    playerData = null;
    playerStatus = null;
    lowerSearchList = [];
    friends = [];
    topSearchList = [];
    searchHistory = [];
  }
}

/// Provider to handle players
final players = ChangeNotifierProvider((ref) => _PlayersNotifier(ref: ref));
