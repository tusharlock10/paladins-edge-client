import "package:paladinsedge/api/base/requests.dart";
import "package:paladinsedge/api/match/responses.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/utilities/index.dart" as utilities;

abstract class MatchRequests {
  static Future<MatchDetailsResponse?> matchDetails({
    required int matchId,
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.matchDetails,
        queryParameters: {"matchId": matchId},
      );
      if (response.data != null) {
        return MatchDetailsResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<PlayerMatchesResponse?> playerMatches({
    required int playerId,
    bool forceUpdate = false,
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.playerMatches,
        queryParameters: {
          "playerId": playerId,
          "forceUpdate": forceUpdate,
        },
      );
      if (response.data != null) {
        return PlayerMatchesResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<SavedMatchesResponse> savedMatches() async {
    final input = ApiRequestInput<SavedMatchesResponse>(
      url: constants.Urls.savedMatches,
      method: HttpMethod.get,
      fromJson: SavedMatchesResponse.fromJson,
      defaultValue: SavedMatchesResponse(),
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<SaveMatchResponse> saveMatch({required int matchId}) async {
    final input = ApiRequestInput<SaveMatchResponse>(
      url: constants.Urls.saveMatch,
      method: HttpMethod.post,
      fromJson: SaveMatchResponse.fromJson,
      defaultValue: SaveMatchResponse(),
      pathParams: {"matchId": matchId},
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<CommonMatchesResponse?> commonMatches({
    required List<int> playerIds,
  }) async {
    try {
      final response = await utilities.api.post<Map<String, dynamic>>(
        constants.Urls.commonMatches,
        data: {"playerIds": playerIds},
      );
      if (response.data != null) {
        return CommonMatchesResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<TopMatchesResponse> topMatches() async {
    final input = ApiRequestInput<TopMatchesResponse>(
      url: constants.Urls.topMatches,
      method: HttpMethod.get,
      fromJson: TopMatchesResponse.fromJson,
      defaultValue: TopMatchesResponse(),
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }
}
