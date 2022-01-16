import 'package:json_annotation/json_annotation.dart';
import 'package:paladinsedge/models/index.dart' show Loadout;

part 'responses.g.dart';

@JsonSerializable()
class PlayerLoadoutsResponse {
  final List<Loadout> loadouts;

  PlayerLoadoutsResponse({required this.loadouts});

  factory PlayerLoadoutsResponse.fromJson(Map<String, dynamic> json) =>
      _$PlayerLoadoutsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerLoadoutsResponseToJson(this);
}
