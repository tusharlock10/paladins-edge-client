// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BountyStoreDetailsResponse _$BountyStoreDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    BountyStoreDetailsResponse(
      bountyStore: (json['bountyStore'] as List<dynamic>)
          .map((e) => BountyStore.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BountyStoreDetailsResponseToJson(
        BountyStoreDetailsResponse instance) =>
    <String, dynamic>{
      'bountyStore': instance.bountyStore,
    };
