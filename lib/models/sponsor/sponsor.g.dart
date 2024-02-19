// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sponsor _$SponsorFromJson(Map<String, dynamic> json) => Sponsor(
      paladinsName: json['paladinsName'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      mode: json['mode'] as String,
    );

Map<String, dynamic> _$SponsorToJson(Sponsor instance) => <String, dynamic>{
      'paladinsName': instance.paladinsName,
      'name': instance.name,
      'email': instance.email,
      'mode': instance.mode,
    };
