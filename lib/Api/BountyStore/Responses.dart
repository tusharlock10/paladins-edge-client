import 'package:json_annotation/json_annotation.dart';

import '../../Models/index.dart' show BountyStore;

part 'Responses.g.dart';

@JsonSerializable()
class BountyStoreDetailsResponse {
  final List<BountyStore> bountyStore;

  BountyStoreDetailsResponse({required this.bountyStore});

  factory BountyStoreDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$BountyStoreDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BountyStoreDetailsResponseToJson(this);
}
