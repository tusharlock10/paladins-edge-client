import "package:paladinsedge/api/champions/responses.dart" as responses;
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/utilities/index.dart" as utilities;

abstract class ChampionsRequests {
  static Future<responses.AllChampionsResponse?> allChampions() async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.allChampions,
      );
      if (response.data != null) {
        return responses.AllChampionsResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.PlayerChampionsResponse?> playerChampions({
    required String playerId,
    bool forceUpdate = false,
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.playerChampions,
        queryParameters: {
          "playerId": playerId,
          "forceUpdate": forceUpdate,
        },
      );
      if (response.data != null) {
        return responses.PlayerChampionsResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.PlayerChampionsResponse?> batchPlayerChampions({
    required List<data_classes.BatchPlayerChampionsPayload>
        playerChampionsQuery,
  }) async {
    final response = await utilities.api.post<Map<String, dynamic>>(
      constants.Urls.batchPlayerChampions,
      data: {
        "playerChampionsQuery": playerChampionsQuery,
      },
    );
    if (response.data != null) {
      return responses.PlayerChampionsResponse.fromJson(response.data!);
    }

    return null;
  }

  static Future<responses.FavouriteChampionsResponse?>
      favouriteChampions() async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.favouriteChampions,
      );
      if (response.data != null) {
        return responses.FavouriteChampionsResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.UpdateFavouriteChampionResponse?>
      updateFavouriteChampion({
    required int championId,
  }) async {
    try {
      final response = await utilities.api.put<Map<String, dynamic>>(
        constants.Urls.updateFavouriteChampion,
        data: {"championId": championId},
      );
      if (response.data != null) {
        return responses.UpdateFavouriteChampionResponse.fromJson(
          response.data!,
        );
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
