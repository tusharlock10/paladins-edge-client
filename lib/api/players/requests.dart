import "package:paladinsedge/api/players/responses.dart" as responses;
import "package:paladinsedge/constants.dart" as constants;
import "package:paladinsedge/utilities/index.dart" as utilities;

abstract class PlayersRequests {
  static Future<responses.SearchPlayersResponse?> searchPlayers({
    required String playerName,
    required bool simpleResults,
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.searchPlayers,
        queryParameters: {
          "playerName": playerName,
          "simpleResults": simpleResults,
        },
      );
      if (response.data != null) {
        return responses.SearchPlayersResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.PlayerDetailResponse?> playerDetail({
    required String playerId,
    required bool forceUpdate,
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.playerDetail,
        queryParameters: {"playerId": playerId, "forceUpdate": forceUpdate},
      );
      if (response.data != null) {
        return responses.PlayerDetailResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.BatchPlayerDetailsResponse?> batchPlayerDetail({
    required List<String> playerIds,
  }) async {
    try {
      final response = await utilities.api.post<Map<String, dynamic>>(
        constants.Urls.batchPlayerDetails,
        data: {"playerIds": playerIds},
      );
      if (response.data != null) {
        return responses.BatchPlayerDetailsResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.PlayerStatusResponse?> playerStatus({
    required String playerId,
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
        return responses.PlayerStatusResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.FriendsResponse?> friends({
    required String playerId,
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.friends,
        queryParameters: {"playerId": playerId},
      );
      if (response.data != null) {
        return responses.FriendsResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.FavouriteFriendsResponse?> favouriteFriends() async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.favouriteFriends,
      );
      if (response.data != null) {
        return responses.FavouriteFriendsResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.UpdateFavouriteFriendResponse?>
      updateFavouriteFriend({
    required String playerId,
  }) async {
    try {
      final response = await utilities.api.put<Map<String, dynamic>>(
        constants.Urls.updateFavouriteFriend,
        data: {"playerId": playerId},
      );
      if (response.data != null) {
        return responses.UpdateFavouriteFriendResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.SearchHistoryResponse?> searchHistory() async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.searchHistory,
      );
      if (response.data != null) {
        return responses.SearchHistoryResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
