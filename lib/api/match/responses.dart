import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/data_classes/index.dart"
    show MatchData, MatchesData;
import "package:paladinsedge/models/index.dart"
    show Match, MatchPlayer, TopMatch;

part "responses.g.dart";

@JsonSerializable()
class MatchDetailsResponse {
  final bool success;
  final String? error;
  final MatchData? data;

  MatchDetailsResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory MatchDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$MatchDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MatchDetailsResponseToJson(this);
}

@JsonSerializable()
class PlayerMatchesResponse {
  final bool success;
  final String? error;
  final MatchesData? data;

  PlayerMatchesResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory PlayerMatchesResponse.fromJson(Map<String, dynamic> json) =>
      _$PlayerMatchesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerMatchesResponseToJson(this);
}

@JsonSerializable()
class SavedMatchesResponse {
  final bool success;
  final String? error;
  final MatchesData? data;

  SavedMatchesResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory SavedMatchesResponse.fromJson(Map<String, dynamic> json) =>
      _$SavedMatchesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SavedMatchesResponseToJson(this);
}

@JsonSerializable()
class UpdateSavedMatchesResponse {
  final List<String> savedMatches;

  UpdateSavedMatchesResponse({
    required this.savedMatches,
  });

  factory UpdateSavedMatchesResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateSavedMatchesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateSavedMatchesResponseToJson(this);
}

@JsonSerializable()
class SaveMatchResponse {
  final bool success;
  final String? error;
  final String? data;

  SaveMatchResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory SaveMatchResponse.fromJson(Map<String, dynamic> json) =>
      _$SaveMatchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SaveMatchResponseToJson(this);
}

@JsonSerializable()
class CommonMatchesResponse {
  final bool success;
  final String? error;
  final MatchesData? data;

  CommonMatchesResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory CommonMatchesResponse.fromJson(Map<String, dynamic> json) =>
      _$CommonMatchesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CommonMatchesResponseToJson(this);
}

@JsonSerializable()
class TopMatchesResponse {
  final bool success;
  final String? error;
  final List<TopMatch>? data;

  TopMatchesResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory TopMatchesResponse.fromJson(Map<String, dynamic> json) =>
      _$TopMatchesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TopMatchesResponseToJson(this);
}
