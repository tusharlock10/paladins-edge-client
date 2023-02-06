import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/api/index.dart" as api;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;

class _FeedbackNotifier extends ChangeNotifier {
  bool isSubmitting = false;
  String description = "";
  String selectedFeedbackType = data_classes.FeedbackTypes.featureRequest;

  /// Changes feedbackType
  void changeDescription(String text) {
    description = text;
    notifyListeners();
  }

  /// Changes feedbackType
  void changeFeedbackType(String feedbackType) {
    selectedFeedbackType = feedbackType;
    notifyListeners();
  }

  /// Submit the feedback
  Future<bool> submitFeedback() async {
    isSubmitting = true;
    notifyListeners();

    final feedback = models.Feedback(
      description: description,
      type: selectedFeedbackType,
    );

    final response = await api.CommonRequests.feedback(feedback: feedback);

    isSubmitting = false;
    notifyListeners();

    return response.success;
  }

  /// Clears all data
  void clearData() {
    isSubmitting = false;
    description = "";
    selectedFeedbackType = data_classes.FeedbackTypes.featureRequest;
  }
}

/// Provider to handle feedback
final feedback = ChangeNotifierProvider((_) => _FeedbackNotifier());
