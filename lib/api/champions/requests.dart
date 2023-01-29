import "package:paladinsedge/api/base/requests.dart";
import "package:paladinsedge/api/champions/responses.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/utilities/index.dart" as utilities;

abstract class ChampionsRequests {
  static Future<ChampionsResponse> champions() async {
    final input = ApiRequestInput<ChampionsResponse>(
      url: constants.Urls.champions,
      method: HttpMethod.get,
      fromJson: ChampionsResponse.fromJson,
      defaultValue: ChampionsResponse(),
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<PlayerChampionsResponse?> playerChampions({
    required int playerId,
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
        return PlayerChampionsResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<PlayerChampionsResponse?> batchPlayerChampions({
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
      return PlayerChampionsResponse.fromJson(response.data!);
    }

    return null;
  }

  static Future<FavouriteChampionsResponse> favouriteChampions() async {
    final input = ApiRequestInput<FavouriteChampionsResponse>(
      url: constants.Urls.favouriteChampions,
      method: HttpMethod.get,
      fromJson: FavouriteChampionsResponse.fromJson,
      defaultValue: FavouriteChampionsResponse(),
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<UpdateFavouriteChampionResponse?> updateFavouriteChampion({
    required int championId,
  }) async {
    try {
      final response = await utilities.api.put<Map<String, dynamic>>(
        constants.Urls.updateFavouriteChampion,
        data: {"championId": championId},
      );
      if (response.data != null) {
        return UpdateFavouriteChampionResponse.fromJson(
          response.data!,
        );
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
