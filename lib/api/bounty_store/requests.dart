import "package:paladinsedge/api/bounty_store/responses.dart" as responses;
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/utilities/index.dart" as utilities;

abstract class BountyStoreRequests {
  static Future<responses.BountyStoreDetailsResponse?>
      bountyStoreDetails() async {
    try {
      final response = await utilities.api
          .get<Map<String, dynamic>>(constants.Urls.bountyStoreDetails);
      if (response.data != null) {
        return responses.BountyStoreDetailsResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
