import 'package:json_annotation/json_annotation.dart';

part 'bounty_store.g.dart';

@JsonSerializable()
class BountyStore {
  /// id of the bounty item
  final String bountyStoreId;

  /// name of the champion skin
  final String skinName;

  /// id of the champion the skin belongs to
  final String championId;

  /// name of the champion the skin belongs to
  final String championName;

  /// final price of the skin in the bounty store
  final String finalPrice;

  /// initial price of the skin
  final String initialPrice;

  /// end date of the skin sale
  final DateTime endDate;

  /// increasing or decreasing sale type
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
