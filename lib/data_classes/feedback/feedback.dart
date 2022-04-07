abstract class FeedbackTypes {
  static const featureRequest = "featureRequest";
  static const suggestion = "suggestion";
  static const bug = "bug";

  static List<String> get feedbackTypes => [featureRequest, suggestion, bug];

  static String getFeedbackTypeText(String feedbackType) {
    switch (feedbackType) {
      case featureRequest:
        return "Feature Request";
      case suggestion:
        return "Suggestion";
      case bug:
        return "Bug";
    }

    return '';
  }
}
