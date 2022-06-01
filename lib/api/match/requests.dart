import "package:paladinsedge/api/match/responses.dart" as responses;
import "package:paladinsedge/constants.dart" as constants;
import "package:paladinsedge/utilities/index.dart" as utilities;

abstract class MatchRequests {
  static Future<responses.MatchDetailsResponse?> matchDetails({
    required String matchId,
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.matchDetails,
        queryParameters: {"matchId": matchId},
      );
      if (response.data != null) {
        return responses.MatchDetailsResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.PlayerMatchesResponse?> playerMatches({
    required String playerId,
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
        return responses.PlayerMatchesResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
