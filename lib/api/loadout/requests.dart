import "package:paladinsedge/api/base/requests.dart";
import "package:paladinsedge/api/loadout/responses.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/models/index.dart" as models;

abstract class LoadoutRequests {
  static Future<PlayerLoadoutsResponse> playerLoadouts({
    required int playerId,
    required int championId,
    bool forceUpdate = false,
  }) async {
    final input = ApiRequestInput(
      url: constants.Urls.playerLoadouts,
      method: HttpMethod.get,
      fromJson: PlayerLoadoutsResponse.fromJson,
      defaultValue: PlayerLoadoutsResponse(),
      pathParams: {
        "playerId": playerId,
      },
      queryParams: {
        "championId": championId,
        "forceUpdate": forceUpdate,
      },
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<CreateLoadoutResponse> createLoadout({
    required models.Loadout loadout,
  }) async {
    final input = ApiRequestInput(
      url: constants.Urls.createLoadout,
      method: HttpMethod.post,
      fromJson: CreateLoadoutResponse.fromJson,
      defaultValue: CreateLoadoutResponse(),
      payload: loadout.toJson(),
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<CreateLoadoutResponse> updateLoadout({
    required models.Loadout loadout,
  }) async {
    final input = ApiRequestInput(
      url: constants.Urls.updateLoadout,
      method: HttpMethod.put,
      fromJson: CreateLoadoutResponse.fromJson,
      defaultValue: CreateLoadoutResponse(),
      payload: loadout.toJson(),
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<CreateLoadoutResponse> deleteLoadout({
    required int loadoutHash,
  }) async {
    final input = ApiRequestInput(
      url: constants.Urls.deleteLoadout,
      method: HttpMethod.delete,
      fromJson: CreateLoadoutResponse.fromJson,
      defaultValue: CreateLoadoutResponse(),
      pathParams: {
        "loadoutHash": loadoutHash,
      },
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }
}
