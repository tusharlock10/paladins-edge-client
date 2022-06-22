// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDetailsResponse _$ItemDetailsResponseFromJson(Map<String, dynamic> json) =>
    ItemDetailsResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemDetailsResponseToJson(
        ItemDetailsResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
