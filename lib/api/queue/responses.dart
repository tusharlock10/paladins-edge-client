import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/models/index.dart" show Queue;

part "responses.g.dart";

@JsonSerializable()
class QueueTimelineResponse {
  final bool success;
  final String? error;
  final List<Queue>? data;

  QueueTimelineResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory QueueTimelineResponse.fromJson(Map<String, dynamic> json) =>
      _$QueueTimelineResponseFromJson(json);
  Map<String, dynamic> toJson() => _$QueueTimelineResponseToJson(this);
}
