import "package:paladinsedge/api/base/requests.dart";
import "package:paladinsedge/api/players/responses.dart";
import "package:paladinsedge/constants/index.dart" as constants;

abstract class PlayersRequests {
  static Future<SearchPlayersResponse> searchPlayers({
    required String playerName,
    required bool simpleResults,
  }) async {
    final input = ApiRequestInput<SearchPlayersResponse>(
      url: constants.Urls.searchPlayers,
      method: HttpMethod.get,
      fromJson: SearchPlayersResponse.fromJson,
      defaultValue: SearchPlayersResponse(),
      pathParams: {"playerName": playerName},
      queryParams: {"simpleResults": simpleResults},
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<PlayerDetailResponse> player({
    required int playerId,
    required bool forceUpdate,
  }) async {
    final input = ApiRequestInput<PlayerDetailResponse>(
      url: constants.Urls.player,
      method: HttpMethod.get,
      fromJson: PlayerDetailResponse.fromJson,
      defaultValue: PlayerDetailResponse(),
      pathParams: {"playerId": playerId},
      queryParams: {"forceUpdate": forceUpdate},
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<BatchPlayerDetailsResponse> batchPlayer({
    required List<int> playerIds,
  }) async {
    final input = ApiRequestInput<BatchPlayerDetailsResponse>(
      url: constants.Urls.batchPlayer,
      method: HttpMethod.post,
      fromJson: BatchPlayerDetailsResponse.fromJson,
      defaultValue: BatchPlayerDetailsResponse(),
      payload: {"playersQuery": playerIds},
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<PlayerStatusResponse> playerStatus({
    required int playerId,
    required bool onlyStatus,
  }) async {
    final input = ApiRequestInput<PlayerStatusResponse>(
      url: constants.Urls.playerStatus,
      method: HttpMethod.get,
      fromJson: PlayerStatusResponse.fromJson,
      defaultValue: PlayerStatusResponse(),
      pathParams: {"playerId": playerId},
      queryParams: {"onlyStatus": onlyStatus},
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<FriendsResponse> friends({
    required int playerId,
  }) async {
    final input = ApiRequestInput<FriendsResponse>(
      url: constants.Urls.friends,
      method: HttpMethod.get,
      fromJson: FriendsResponse.fromJson,
      defaultValue: FriendsResponse(),
      pathParams: {"playerId": playerId},
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<FavouriteFriendsResponse> favouriteFriends() async {
    final input = ApiRequestInput<FavouriteFriendsResponse>(
      url: constants.Urls.searchPlayers,
      method: HttpMethod.get,
      fromJson: FavouriteFriendsResponse.fromJson,
      defaultValue: FavouriteFriendsResponse(),
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<UpdateFavouriteFriendResponse> updateFavouriteFriend({
    required int playerId,
  }) async {
    final input = ApiRequestInput<UpdateFavouriteFriendResponse>(
      url: constants.Urls.markFavouriteFriend,
      method: HttpMethod.post,
      fromJson: UpdateFavouriteFriendResponse.fromJson,
      defaultValue: UpdateFavouriteFriendResponse(),
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<SearchHistoryResponse> searchHistory() async {
    final input = ApiRequestInput<SearchHistoryResponse>(
      url: constants.Urls.searchHistory,
      method: HttpMethod.get,
      fromJson: SearchHistoryResponse.fromJson,
      defaultValue: SearchHistoryResponse(),
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<PlayerInferredResponse> playerInferred({
    required int playerId,
  }) async {
    final input = ApiRequestInput<PlayerInferredResponse>(
      url: constants.Urls.playerInferred,
      method: HttpMethod.get,
      fromJson: PlayerInferredResponse.fromJson,
      defaultValue: PlayerInferredResponse(),
      pathParams: {"playerId": playerId},
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }
}
