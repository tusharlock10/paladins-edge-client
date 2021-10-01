import './Responses.dart' as Responses;
import '../../Constants.dart' as Constants;
import '../../Utilities/index.dart' as Utilities;

abstract class BountyStoreRequests {
  static Future<Responses.BountyStoreDetailsResponse>
      bountyStoreDetails() async {
    final response = await Utilities.api.get(Constants.Urls.bountyStoreDetails);
    return Responses.BountyStoreDetailsResponse.fromJson(response.data);
  }
}
