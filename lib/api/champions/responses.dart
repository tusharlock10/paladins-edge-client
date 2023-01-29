import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/models/index.dart" show Champion, PlayerChampion;

part "responses.g.dart";

@JsonSerializable()
class ChampionsResponse {
  final bool success;
  final String? error;
  final List<Champion>? data;

  ChampionsResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory ChampionsResponse.fromJson(Map<String, dynamic> json) =>
      _$ChampionsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChampionsResponseToJson(this);
}

@JsonSerializable()
class PlayerChampionsResponse {
  final List<PlayerChampion> playerChampions;

  PlayerChampionsResponse({required this.playerChampions});

  factory PlayerChampionsResponse.fromJson(Map<String, dynamic> json) =>
      _$PlayerChampionsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerChampionsResponseToJson(this);
}

@JsonSerializable()
class FavouriteChampionsResponse {
  final bool success;
  final String? error;
  final List<int>? data;

  FavouriteChampionsResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory FavouriteChampionsResponse.fromJson(Map<String, dynamic> json) =>
      _$FavouriteChampionsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FavouriteChampionsResponseToJson(this);
}

@JsonSerializable()
class UpdateFavouriteChampionResponse {
  final List<int> favouriteChampions;

  UpdateFavouriteChampionResponse({required this.favouriteChampions});

  factory UpdateFavouriteChampionResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateFavouriteChampionResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$UpdateFavouriteChampionResponseToJson(this);
}
