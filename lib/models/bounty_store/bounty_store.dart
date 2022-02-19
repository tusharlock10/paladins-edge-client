import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paladinsedge/constants.dart' show TypeIds;

part 'bounty_store.g.dart';

@HiveType(typeId: TypeIds.bountyStore)
@JsonSerializable()
class BountyStore {
  /// id of the bounty item
  @HiveField(0)
  final String bountyStoreId;

  /// name of the champion skin
  @HiveField(1)
  final String skinName;

  /// id of the champion the skin belongs to
  @HiveField(2)
  final int championId;

  /// name of the champion the skin belongs to
  @HiveField(3)
  final String championName;

  /// final price of the skin in the bounty store
  @HiveField(4)
  final String finalPrice;

  /// initial price of the skin
  @HiveField(5)
  final String initialPrice;

  /// end date of the skin sale
  @HiveField(6)
  final DateTime endDate;

  /// increasing or decreasing sale type
  @HiveField(7)
  final String type;

  BountyStore({
    required this.bountyStoreId,
    required this.skinName,
    required this.championId,
    required this.championName,
    required this.finalPrice,
    required this.initialPrice,
    required this.endDate,
    required this.type,
  });

  factory BountyStore.fromJson(Map<String, dynamic> json) =>
      _$BountyStoreFromJson(json);
  Map<String, dynamic> toJson() => _$BountyStoreToJson(this);
}
