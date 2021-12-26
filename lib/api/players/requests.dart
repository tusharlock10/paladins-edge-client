import 'package:paladinsedge/api/players/responses.dart' as responses;
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/utilities/index.dart' as utilities;

abstract class PlayersRequests {
  static Future<responses.SearchPlayersResponse?> searchPlayers({
    required String playerName,
    required bool simpleResults,
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.searchPlayers,
        queryParameters: {
          'playerName': playerName,
          'simpleResults': simpleResults,
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
        queryParameters: {'playerId': playerId, 'forceUpdate': forceUpdate},
      );
      if (response.data != null) {
        return responses.PlayerDetailResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.PlayerStatusResponse?> playerStatus({
    required String playerId,
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.playerStatus,
        queryParameters: {'playerId': playerId},
      );
      if (response.data != null) {
        return responses.PlayerStatusResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.FriendsListResponse?> friendsList({
    required String playerId,
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.friendsList,
        queryParameters: {'playerId': playerId},
      );
      if (response.data != null) {
        return responses.FriendsListResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.FavouriteFriendResponse?> favouriteFriend({
    required String playerId,
  }) async {
    try {
      final response = await utilities.api.put<Map<String, dynamic>>(
        constants.Urls.favouriteFriend,
        data: {'playerId': playerId},
      );
      if (response.data != null) {
        return responses.FavouriteFriendResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
