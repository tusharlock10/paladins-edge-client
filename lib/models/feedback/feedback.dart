import 'package:json_annotation/json_annotation.dart';

part 'feedback.g.dart';

abstract class FeedbackTypes {
  static const featureRequest = "featureRequest";
  static const suggestion = "suggestion";

  static String getFeedbackTypeText(String feedbackType) {
    switch (feedbackType) {
      case featureRequest:
        return "Feature Request";
      case suggestion:
        return "Suggestion";
    }

    return '';
  }

  static List<String> getFeedbackTypes() {
    return [
      featureRequest,
      suggestion,
    ];
  }
}

@JsonSerializable()
class Feedback {
  String description;
  String type;
  String? imageUrl;

  Feedback({
    required this.description,
    required this.type,
    this.imageUrl,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) =>
      _$FeedbackFromJson(json);
  Map<String, dynamic> toJson() => _$FeedbackToJson(this);
}
