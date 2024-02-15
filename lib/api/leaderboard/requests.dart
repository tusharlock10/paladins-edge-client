import "package:paladinsedge/api/leaderboard/responses.dart" as responses;
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/utilities/index.dart" as utilities;

abstract class LeaderboardRequests {
  static Future<responses.LeaderboardPlayerResponse?> leaderboardPlayers(
    int rank,
  ) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.leaderboardPlayers,
        queryParameters: {"rank": rank},
      );
      if (response.data != null) {
        return responses.LeaderboardPlayerResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
