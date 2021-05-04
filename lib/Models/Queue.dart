import 'package:json_annotation/json_annotation.dart';

part 'Queue.g.dart';

@JsonSerializable()
class Queue {
  final String queueId; // Queue Id of the game mode provided by paladins API
  final String name; // name of the queue/ game mode
  final int
      activeMatchCount; // Number of matches being played currently in this

  Queue({
    required this.queueId,
    required this.name,
    required this.activeMatchCount,
  });

  factory Queue.fromJson(Map<String, dynamic> json) => _$QueueFromJson(json);
  Map<String, dynamic> toJson() => _$QueueToJson(this);
}
