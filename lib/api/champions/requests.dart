import 'package:paladinsedge/api/champions/responses.dart' as responses;
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/utilities/index.dart' as utilities;

abstract class ChampionsRequests {
  static Future<responses.AllChampionsResponse?> allChampions(
      {required bool allData}) async {
    final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.allChampions,
        queryParameters: {'allData': allData});
    if (response.data != null) {
      return responses.AllChampionsResponse.fromJson(response.data!);
    }
  }

  static Future<responses.PlayerChampionsResponse?> playerChampions(
      {required String playerId}) async {
    final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.playerChampions,
        queryParameters: {'playerId': playerId});
    if (response.data != null) {
      return responses.PlayerChampionsResponse.fromJson(response.data!);
    }
  }
}