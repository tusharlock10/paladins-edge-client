import "package:hive/hive.dart";
import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/constants/index.dart" show TypeIds;

part "queue.g.dart";

@HiveType(typeId: TypeIds.queueRegion)
@JsonSerializable()
class QueueRegion {
  /// region of the matches
  @HiveField(0)
  final String region;

  /// Number of matches being played currently in this region
  @HiveField(1)
  final int activeMatchCount;

  QueueRegion({
    required this.region,
    required this.activeMatchCount,
  });

  factory QueueRegion.fromJson(Map<String, dynamic> json) =>
      _$QueueRegionFromJson(json);
  Map<String, dynamic> toJson() => _$QueueRegionToJson(this);
}

@HiveType(typeId: TypeIds.queue)
@JsonSerializable()
class Queue {
  /// Queue Id of the game mode provided by paladins API
  @HiveField(0)
  final int queueId;

  /// name of the queue/ game mode
  @HiveField(1)
  final String name;

  /// Number of matches being played currently in this
  @HiveField(2)
  final int activeMatchCount;

  /// DateTime at which this queue data was created
  @HiveField(3)
  final DateTime createdAt;

  /// A breakup of the matches by region
  @HiveField(4, defaultValue: [])
  final List<QueueRegion> queueRegions;

  Queue({
    required this.queueId,
    required this.name,
    required this.activeMatchCount,
    required this.createdAt,
    required this.queueRegions,
  });

  factory Queue.fromJson(Map<String, dynamic> json) => _$QueueFromJson(json);
  Map<String, dynamic> toJson() => _$QueueToJson(this);
}
