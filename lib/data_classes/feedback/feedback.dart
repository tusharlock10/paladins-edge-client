abstract class FeedbackTypes {
  static const featureRequest = "featureRequest";
  static const suggestion = "suggestion";
  static const bug = "bug";
  static const support = "support";

  static List<String> get feedbackTypes => [
        featureRequest,
        suggestion,
        bug,
        support,
      ];

  static String getFeedbackTypeText(String feedbackType) {
    switch (feedbackType) {
      case featureRequest:
        return "Feature Request";
      case suggestion:
        return "Suggestion";
      case bug:
        return "Bug";
      case support:
        return "Support";
    }

    return "";
  }
}
