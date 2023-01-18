import "package:paladinsedge/api/base/requests.dart";
import "package:paladinsedge/api/queue/responses.dart";
import "package:paladinsedge/constants/index.dart" as constants;

abstract class QueueRequests {
  static Future<QueueTimelineResponse> queueTimeline() async {
    final input = ApiRequestInput<QueueTimelineResponse>(
      url: constants.Urls.queueTimeline,
      method: HttpMethod.get,
      fromJson: QueueTimelineResponse.fromJson,
      defaultValue: QueueTimelineResponse(),
    );
    final response = await ApiRequest.apiRequest(input);

    return response;
  }
}
