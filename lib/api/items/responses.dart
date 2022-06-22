import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/models/index.dart" show Item;

part "responses.g.dart";

@JsonSerializable()
class ItemDetailsResponse {
  final List<Item> items;

  ItemDetailsResponse({required this.items});

  factory ItemDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ItemDetailsResponseToJson(this);
}
