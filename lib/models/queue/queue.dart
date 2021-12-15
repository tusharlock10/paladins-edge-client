import 'package:json_annotation/json_annotation.dart';

part 'queue.g.dart';

@JsonSerializable()
class Queue {
  /// Queue Id of the game mode provided by paladins API
  final String queueId;

  /// name of the queue/ game mode
  final String name;

  /// Number of matches being played currently in this
  final int activeMatchCount;

  Queue({
    required this.queueId,
    required this.name,
    required this.activeMatchCount,
  });

  factory Queue.fromJson(Map<String, dynamic> json) => _$QueueFromJson(json);
  Map<String, dynamic> toJson() => _$QueueToJson(this);
}
