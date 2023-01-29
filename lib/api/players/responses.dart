import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/data_classes/index.dart" show SearchPlayersData;
import "package:paladinsedge/models/index.dart"
    show Player, ActiveMatch, SearchHistory, PlayerInferred;

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
  final Player player;

  PlayerDetailResponse({required this.player});

  factory PlayerDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$PlayerDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerDetailResponseToJson(this);
}

@JsonSerializable()
class BatchPlayerDetailsResponse {
  final List<Player> players;

  BatchPlayerDetailsResponse({required this.players});

  factory BatchPlayerDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$BatchPlayerDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BatchPlayerDetailsResponseToJson(this);
}

@JsonSerializable()
class PlayerStatusResponse {
  final int playerId;
  final bool inMatch;
  final String status;
  final ActiveMatch? match;

  PlayerStatusResponse({
    required this.playerId,
    required this.inMatch,
    required this.status,
    required this.match,
  });

  factory PlayerStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$PlayerStatusResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerStatusResponseToJson(this);
}

@JsonSerializable()
class FriendsResponse {
  final List<Player> friends;

  FriendsResponse({required this.friends});

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
  final List<String> favouriteFriends;

  UpdateFavouriteFriendResponse({required this.favouriteFriends});

  factory UpdateFavouriteFriendResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateFavouriteFriendResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateFavouriteFriendResponseToJson(this);
}

@JsonSerializable()
class SearchHistoryResponse {
  final List<SearchHistory> searchHistory;

  SearchHistoryResponse({
    required this.searchHistory,
  });

  factory SearchHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchHistoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchHistoryResponseToJson(this);
}

@JsonSerializable()
class PlayerInferredResponse {
  final PlayerInferred playerInferred;

  PlayerInferredResponse({
    required this.playerInferred,
  });

  factory PlayerInferredResponse.fromJson(Map<String, dynamic> json) =>
      _$PlayerInferredResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerInferredResponseToJson(this);
}
