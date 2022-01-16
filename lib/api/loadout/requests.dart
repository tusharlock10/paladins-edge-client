import 'package:paladinsedge/api/loadout/responses.dart' as responses;
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/utilities/index.dart' as utilities;

abstract class LoadoutRequests {
  static Future<responses.PlayerLoadoutsResponse?> playerLoadouts({
    required String playerId,
    required String championId,
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.playerLoadouts,
        queryParameters: {
          'playerId': playerId,
          'championId': championId,
        },
      );
      if (response.data != null) {
        return responses.PlayerLoadoutsResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
