import './Responses.dart' as Responses;
import '../../Constants.dart' as Constants;
import '../../Utilities/index.dart' as Utilities;

abstract class ChampionsRequests {
  static Future<Responses.AllChampionsResponse> allChampions(
      {required bool allData}) async {
    final response = await Utilities.api.get(Constants.Urls.allChampions,
        queryParameters: {'allData': allData});
    return Responses.AllChampionsResponse.fromJson(response.data);
  }

  static Future<Responses.PlayerChampionsResponse> playerChampions(
      {required String playerId}) async {
    final response = await Utilities.api.get(Constants.Urls.playerChampions,
        queryParameters: {'playerId': playerId});

    return Responses.PlayerChampionsResponse.fromJson(response.data);
  }
}
