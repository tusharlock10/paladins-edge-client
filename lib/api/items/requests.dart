import "package:paladinsedge/api/items/responses.dart" as responses;
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/utilities/index.dart" as utilities;

abstract class ItemRequests {
  static Future<responses.ItemDetailsResponse?> itemDetails() async {
    try {
      final response = await utilities.api
          .get<Map<String, dynamic>>(constants.Urls.itemDetails);
      if (response.data != null) {
        return responses.ItemDetailsResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
