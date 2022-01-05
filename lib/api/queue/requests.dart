import 'package:paladinsedge/api/queue/responses.dart' as responses;
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/utilities/index.dart' as utilities;

abstract class QueueRequests {
  static Future<responses.QueueDetailsResponse?> queueDetails() async {
    try {
      final response = await utilities.api
          .get<Map<String, dynamic>>(constants.Urls.queueDetails);
      if (response.data != null) {
        return responses.QueueDetailsResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
