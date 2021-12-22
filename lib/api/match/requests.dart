import 'package:paladinsedge/api/match/responses.dart' as responses;
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/utilities/index.dart' as utilities;

abstract class MatchRequests {
  static Future<responses.MatchDetailsResponse?> matchDetails({
    required String playerId,
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.matchDetails,
        queryParameters: {'playerId': playerId},
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
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.playerMatches,
        queryParameters: {'playerId': playerId},
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
