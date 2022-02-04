import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paladinsedge/constants.dart' show TypeIds;

part 'queue.g.dart';

@HiveType(typeId: TypeIds.queue)
@JsonSerializable()
class Queue {
  /// Queue Id of the game mode provided by paladins API
  @HiveField(0)
  final String queueId;

  /// name of the queue/ game mode
  @HiveField(1)
  final String name;

  /// Number of matches being played currently in this
  @HiveField(2)
  final int activeMatchCount;

  /// DateTime at which this queue data was created
  @HiveField(3)
  final DateTime createdAt;

  Queue({
    required this.queueId,
    required this.name,
    required this.activeMatchCount,
    required this.createdAt,
  });

  factory Queue.fromJson(Map<String, dynamic> json) => _$QueueFromJson(json);
  Map<String, dynamic> toJson() => _$QueueToJson(this);
}
