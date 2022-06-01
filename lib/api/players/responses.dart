import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/models/index.dart"
    show Player, ActiveMatch, SearchHistory;

part "responses.g.dart";

@JsonSerializable()
class LowerSearch {
  final String name;
  final String playerId;
  final bool isPrivate;
  final String platform;

  LowerSearch({
    required this.name,
    required this.playerId,
    required this.isPrivate,
    required this.platform,
  });

  factory LowerSearch.fromJson(Map<String, dynamic> json) =>
      _$LowerSearchFromJson(json);
  Map<String, dynamic> toJson() => _$LowerSearchToJson(this);
}

@JsonSerializable()
class SearchData {
  final List<Player> topSearchList;
  final List<LowerSearch> lowerSearchList;

  SearchData({required this.lowerSearchList, required this.topSearchList});

  factory SearchData.fromJson(Map<String, dynamic> json) =>
      _$SearchDataFromJson(json);
  Map<String, dynamic> toJson() => _$SearchDataToJson(this);
}

@JsonSerializable()
class SearchPlayersResponse {
  final SearchData searchData;
  final bool exactMatch;
  final Player? playerData;

  SearchPlayersResponse({
    required this.searchData,
    required this.exactMatch,
    this.playerData,
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
  final String status;
  final ActiveMatch? match;

  PlayerStatusResponse({required this.status, required this.match});

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
  final List<Player> favouriteFriends;

  FavouriteFriendsResponse({required this.favouriteFriends});

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
