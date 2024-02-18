import "package:paladinsedge/api/base_ranks/responses.dart" as responses;
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/utilities/index.dart" as utilities;

abstract class BaseRankRequests {
  static Future<responses.BaseRankResponse?> baseRanks() async {
    try {
      final response = await utilities.api
          .get<Map<String, dynamic>>(constants.Urls.baseRanks);
      if (response.data != null) {
        return responses.BaseRankResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
