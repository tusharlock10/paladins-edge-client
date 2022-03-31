import 'package:paladinsedge/api/feedback/responses.dart' as responses;
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;

abstract class FeedbackRequests {
  static Future<responses.UploadImageUrlResponse?> uploadImageUrl({
    required String fileName,
  }) async {
    try {
      final response = await utilities.api.get<Map<String, dynamic>>(
        constants.Urls.uploadImageUrl,
        queryParameters: {'fileName': fileName},
      );
      if (response.data != null) {
        return responses.UploadImageUrlResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<responses.SubmitFeedbackResponse?> submitFeedback({
    required models.Feedback feedback,
  }) async {
    try {
      final response = await utilities.api.post<Map<String, dynamic>>(
        constants.Urls.submitFeedback,
        data: {
          'feedback': feedback,
        },
      );
      if (response.data != null) {
        return responses.SubmitFeedbackResponse.fromJson(response.data!);
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
