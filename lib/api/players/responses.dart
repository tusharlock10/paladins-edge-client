import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/data_classes/index.dart"
    show SearchPlayersData, PlayerStatus;
import "package:paladinsedge/models/index.dart"
    show Player, SearchHistory, PlayerInferred;

part "responses.g.dart";

@JsonSerializable()
class SearchPlayersResponse {
  final bool success;
  final String? error;
  final SearchPlayersData? data;

  SearchPlayersResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory SearchPlayersResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchPlayersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchPlayersResponseToJson(this);
}

@JsonSerializable()
class PlayerDetailResponse {
  final bool success;
  final String? error;
  final Player? data;

  PlayerDetailResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory PlayerDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$PlayerDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerDetailResponseToJson(this);
}

@JsonSerializable()
class BatchPlayerDetailsResponse {
  final bool success;
  final String? error;
  final List<Player>? data;

  BatchPlayerDetailsResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory BatchPlayerDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$BatchPlayerDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BatchPlayerDetailsResponseToJson(this);
}

@JsonSerializable()
class PlayerStatusResponse {
  final bool success;
  final String? error;
  final PlayerStatus? data;

  PlayerStatusResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory PlayerStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$PlayerStatusResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerStatusResponseToJson(this);
}

@JsonSerializable()
class FriendsResponse {
  final bool success;
  final String? error;
  final List<Player>? data;

  FriendsResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory FriendsResponse.fromJson(Map<String, dynamic> json) =>
      _$FriendsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FriendsResponseToJson(this);
}

@JsonSerializable()
class FavouriteFriendsResponse {
  final bool success;
  final String? error;
  final List<Player>? data;

  FavouriteFriendsResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory FavouriteFriendsResponse.fromJson(Map<String, dynamic> json) =>
      _$FavouriteFriendsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FavouriteFriendsResponseToJson(this);
}

@JsonSerializable()
class UpdateFavouriteFriendResponse {
  final bool success;
  final String? error;
  final String? data;

  UpdateFavouriteFriendResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory UpdateFavouriteFriendResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateFavouriteFriendResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateFavouriteFriendResponseToJson(this);
}

@JsonSerializable()
class SearchHistoryResponse {
  final bool success;
  final String? error;
  final List<SearchHistory>? data;

  SearchHistoryResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory SearchHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchHistoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchHistoryResponseToJson(this);
}

@JsonSerializable()
class PlayerInferredResponse {
  final bool success;
  final String? error;
  final PlayerInferred? data;

  PlayerInferredResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory PlayerInferredResponse.fromJson(Map<String, dynamic> json) =>
      _$PlayerInferredResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerInferredResponseToJson(this);
}
