import 'package:json_annotation/json_annotation.dart';

part 'bounty_store.g.dart';

@JsonSerializable()
class BountyStore {
  final String bountyStoreId; // id of the bounty item
  final String skinName; // name of the champion skin
  final String championId; // id of the champion the skin belongs to
  final String championName; // name of the champion the skin belongs to
  final String finalPrice; // final price of the skin in the bounty store
  final String initialPrice; // initial price of the skin
  final DateTime endDate; // end date of the skin sale
  final String type; // increasing or decreasing sale type

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
