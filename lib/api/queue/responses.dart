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

@JsonSerializable()
class QueueTimelineResponse {
  final List<Queue> timeline;

  QueueTimelineResponse({required this.timeline});

  factory QueueTimelineResponse.fromJson(Map<String, dynamic> json) =>
      _$QueueTimelineResponseFromJson(json);
  Map<String, dynamic> toJson() => _$QueueTimelineResponseToJson(this);
}
