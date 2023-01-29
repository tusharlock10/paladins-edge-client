import "package:json_annotation/json_annotation.dart";

part "faq.g.dart";

@JsonSerializable()
class FAQ {
  int position;
  String title;
  String body;

  FAQ({
    required this.position,
    required this.title,
    required this.body,
  });

  factory FAQ.fromJson(Map<String, dynamic> json) => _$FAQFromJson(json);
  Map<String, dynamic> toJson() => _$FAQToJson(this);
}
