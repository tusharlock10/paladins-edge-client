import "package:json_annotation/json_annotation.dart";

part "feedback.g.dart";

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
