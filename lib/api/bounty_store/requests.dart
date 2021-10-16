import 'package:paladinsedge/api/bounty_store/responses.dart' as responses;
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/utilities/index.dart' as utilities;

abstract class BountyStoreRequests {
  static Future<responses.BountyStoreDetailsResponse?>
      bountyStoreDetails() async {
    final response = await utilities.api
        .get<Map<String, dynamic>>(constants.Urls.bountyStoreDetails);
    if (response.data != null) {
      return responses.BountyStoreDetailsResponse.fromJson(response.data!);
    }
  }
}
