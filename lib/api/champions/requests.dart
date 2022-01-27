import 'package:paladinsedge/api/champions/responses.dart' as responses;
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/utilities/index.dart' as utilities;

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
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.playerChampions,
        queryParameters: {
          'playerId': playerId,
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
        'playerChampionsQuery': playerChampionsQuery,
      },
    );
    if (response.data != null) {
      return responses.PlayerChampionsResponse.fromJson(response.data!);
    }

    return null;
  }
}
