import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/models/index.dart" show BountyStore;

part "responses.g.dart";

@JsonSerializable()
class BountyStoreDetailsResponse {
  final List<BountyStore> bountyStore;

  BountyStoreDetailsResponse({required this.bountyStore});

  factory BountyStoreDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$BountyStoreDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BountyStoreDetailsResponseToJson(this);
}
