// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BountyStore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BountyStore _$BountyStoreFromJson(Map<String, dynamic> json) {
  return BountyStore(
    bountyStoreId: json['bountyStoreId'] as String,
    skinName: json['skinName'] as String,
    championId: json['championId'] as String,
    championName: json['championName'] as String,
    finalPrice: json['finalPrice'] as String,
    initialPrice: json['initialPrice'] as String,
    endDate: DateTime.parse(json['endDate'] as String),
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$BountyStoreToJson(BountyStore instance) =>
    <String, dynamic>{
      'bountyStoreId': instance.bountyStoreId,
      'skinName': instance.skinName,
      'championId': instance.championId,
      'championName': instance.championName,
      'finalPrice': instance.finalPrice,
      'initialPrice': instance.initialPrice,
      'endDate': instance.endDate.toIso8601String(),
      'type': instance.type,
    };
