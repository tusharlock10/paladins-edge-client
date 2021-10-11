import './Responses.dart' as Responses;
import '../../Constants.dart' as Constants;
import '../../Utilities/index.dart' as Utilities;

abstract class PlayersRequests {
  static Future<Responses.SearchPlayersResponse> searchPlayers({
    required String playerName,
    required bool simpleResults,
  }) async {
    final response = await Utilities.api.get(
      Constants.Urls.searchPlayers,
      queryParameters: {
        'playerName': playerName,
        'simpleResults': simpleResults
      },
    );

    return Responses.SearchPlayersResponse.fromJson(response.data);
  }

  static Future<Responses.PlayerDetailResponse> playerDetail(
      {required String playerId}) async {
    final response = await Utilities.api.get(
      Constants.Urls.playerDetail,
      queryParameters: {'playerId': playerId},
    );

    return Responses.PlayerDetailResponse.fromJson(response.data);
  }

  static Future<Responses.PlayerStatusResponse> playerStatus(
      {required String playerId}) async {
    final response = await Utilities.api.get(
      Constants.Urls.playerStatus,
      queryParameters: {'playerId': playerId},
    );

    return Responses.PlayerStatusResponse.fromJson(response.data);
  }

  static Future<Responses.FriendsListResponse> friendsList(
      {required String playerId}) async {
    final response = await Utilities.api.get(
      Constants.Urls.friendsList,
      queryParameters: {'playerId': playerId},
    );

    return Responses.FriendsListResponse.fromJson(response.data);
  }

  static Future<Responses.FavouriteFriendResponse> favouriteFriend(
      {required String playerId}) async {
    final response = await Utilities.api.put(
      Constants.Urls.favouriteFriend,
      data: {'playerId': playerId},
    );

    return Responses.FavouriteFriendResponse.fromJson(response.data);
  }
}
