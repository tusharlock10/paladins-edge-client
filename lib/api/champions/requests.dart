import "package:paladinsedge/api/base/requests.dart";
import "package:paladinsedge/api/champions/responses.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;

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

  static Future<PlayerChampionsResponse> playerChampions({
    required int playerId,
    bool forceUpdate = false,
  }) async {
    final input = ApiRequestInput<PlayerChampionsResponse>(
      url: constants.Urls.playerChampions,
      method: HttpMethod.get,
      fromJson: PlayerChampionsResponse.fromJson,
      defaultValue: PlayerChampionsResponse(),
      queryParams: {"forceUpdate": forceUpdate},
      pathParams: {"playerId": playerId},
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<PlayerChampionsResponse> batchPlayerChampions({
    required List<data_classes.BatchPlayerChampionsPayload>
        playerChampionsQuery,
  }) async {
    final input = ApiRequestInput<PlayerChampionsResponse>(
      url: constants.Urls.batchPlayerChampions,
      method: HttpMethod.post,
      fromJson: PlayerChampionsResponse.fromJson,
      defaultValue: PlayerChampionsResponse(),
      payload: {"playerChampionsQuery": playerChampionsQuery},
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
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

  static Future<UpdateFavouriteChampionResponse> markFavouriteChampion({
    required int championId,
  }) async {
    final input = ApiRequestInput<UpdateFavouriteChampionResponse>(
      url: constants.Urls.markFavouriteChampion,
      method: HttpMethod.post,
      fromJson: UpdateFavouriteChampionResponse.fromJson,
      defaultValue: UpdateFavouriteChampionResponse(),
      pathParams: {"championId": championId},
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }
}
