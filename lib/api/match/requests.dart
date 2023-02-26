import "package:paladinsedge/api/base/requests.dart";
import "package:paladinsedge/api/match/responses.dart";
import "package:paladinsedge/constants/index.dart" as constants;

abstract class MatchRequests {
  static Future<MatchDetailsResponse> matchDetails({
    required int matchId,
  }) async {
    final input = ApiRequestInput<MatchDetailsResponse>(
      url: constants.Urls.matchDetails,
      method: HttpMethod.get,
      fromJson: MatchDetailsResponse.fromJson,
      defaultValue: MatchDetailsResponse(),
      pathParams: {"matchId": matchId},
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }

  static Future<PlayerMatchesResponse> playerMatches({
    required int playerId,
    bool forceUpdate = false,
  }) async {
    final input = ApiRequestInput<PlayerMatchesResponse>(
      url: constants.Urls.playerMatches,
      method: HttpMethod.get,
      fromJson: PlayerMatchesResponse.fromJson,
      defaultValue: PlayerMatchesResponse(),
      pathParams: {"playerId": playerId},
      queryParams: {"forceUpdate": forceUpdate},
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
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

  static Future<CommonMatchesResponse> commonMatches({
    required List<int> playerIds,
  }) async {
    final newPlayerIds = playerIds.join(",");
    final input = ApiRequestInput<CommonMatchesResponse>(
      url: constants.Urls.commonMatches,
      method: HttpMethod.get,
      fromJson: CommonMatchesResponse.fromJson,
      defaultValue: CommonMatchesResponse(),
      queryParams: {"playerIds": newPlayerIds},
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
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
