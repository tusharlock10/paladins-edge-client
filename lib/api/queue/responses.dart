import 'package:json_annotation/json_annotation.dart';
import 'package:paladinsedge/models/index.dart' show Queue;

part 'responses.g.dart';

@JsonSerializable()
class QueueDetailsResponse {
  final List<Queue> queue;

  QueueDetailsResponse({required this.queue});

  factory QueueDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$QueueDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$QueueDetailsResponseToJson(this);
}
