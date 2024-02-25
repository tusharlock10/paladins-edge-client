import "package:json_annotation/json_annotation.dart";

part "sponsor.g.dart";

@JsonSerializable()
class Sponsor {
  /// paladins IGN of the sponsor
  final String paladinsName;

  /// name of the sponsor
  final String name;

  /// mode of the sponsorship
  final String mode;

  Sponsor({
    required this.paladinsName,
    required this.name,
    required this.mode,
  });

  factory Sponsor.fromJson(Map<String, dynamic> json) =>
      _$SponsorFromJson(json);
  Map<String, dynamic> toJson() => _$SponsorToJson(this);
}
