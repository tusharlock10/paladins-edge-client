import "package:hive/hive.dart";
import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/constants.dart" show TypeIds;
import "package:paladinsedge/utilities/index.dart" as utilities;

part "item.g.dart";

@HiveType(typeId: TypeIds.item)
@JsonSerializable()
class Item {
  /// id of the item according to paladins api
  @HiveField(0)
  final int itemId;

  /// name of the item
  @HiveField(1)
  final String name;

  /// description of the item
  @HiveField(2)
  final String description;

  /// price of the item in game
  @HiveField(3)
  final int price;

  /// image url of the item
  @HiveField(4)
  final String imageUrl;

  /// blur hash of the item image
  @HiveField(5)
  final String? imageBlurHash;

  Item({
    required this.itemId,
    required this.name,
    required this.description,
    required this.price,
    required this.imageBlurHash,
    required String imageUrl,
  }) : imageUrl = utilities.getUrlFromKey(imageUrl);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
