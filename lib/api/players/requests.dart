import "package:paladinsedge/api/base/requests.dart";
import "package:paladinsedge/api/players/responses.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/utilities/index.dart" as utilities;

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
      pathParams: {
        "playerName": playerName,
      },
      queryParams: {
        "simpleResults": simpleResults.toString(),
      },
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<PlayerDetailResponse?> playerDetail({
    required int playerId,
    required bool forceUpdate,
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.playerDetail,
        queryParameters: {"playerId": playerId, "forceUpdate": forceUpdate},
      );
      if (response.data != null) {
        return PlayerDetailResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<BatchPlayerDetailsResponse?> batchPlayerDetail({
    required List<int> playerIds,
  }) async {
    try {
      final response = await utilities.api.post<Map<String, dynamic>>(
        constants.Urls.batchPlayerDetails,
        data: {"playerIds": playerIds},
      );
      if (response.data != null) {
        return BatchPlayerDetailsResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<PlayerStatusResponse?> playerStatus({
    required int playerId,
    bool onlyStatus = false,
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.playerStatus,
        queryParameters: {
          "playerId": playerId,
          "onlyStatus": onlyStatus,
        },
      );
      if (response.data != null) {
        return PlayerStatusResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<FriendsResponse?> friends({
    required int playerId,
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.friends,
        queryParameters: {"playerId": playerId},
      );
      if (response.data != null) {
        return FriendsResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
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

  static Future<UpdateFavouriteFriendResponse?> updateFavouriteFriend({
    required int playerId,
  }) async {
    try {
      final response = await utilities.api.put<Map<String, dynamic>>(
        constants.Urls.updateFavouriteFriend,
        data: {"playerId": playerId},
      );
      if (response.data != null) {
        return UpdateFavouriteFriendResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<SearchHistoryResponse?> searchHistory() async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.searchHistory,
      );
      if (response.data != null) {
        return SearchHistoryResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<PlayerInferredResponse?> playerInferred({
    required int playerId,
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.playerInferred,
        queryParameters: {"playerId": playerId},
      );
      if (response.data != null) {
        return PlayerInferredResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
