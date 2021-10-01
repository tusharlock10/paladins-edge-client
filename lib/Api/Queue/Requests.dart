import './Responses.dart' as Responses;
import '../../Constants.dart' as Constants;
import '../../Utilities/index.dart' as Utilities;

abstract class QueueRequests {
  static Future<Responses.QueueDetailsResponse> queueDetails() async {
    final response = await Utilities.api.get(Constants.Urls.queueDetails);
    return Responses.QueueDetailsResponse.fromJson(response.data);
  }
}
