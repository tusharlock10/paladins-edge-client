import 'package:json_annotation/json_annotation.dart';
import 'package:paladinsedge/models/index.dart' show Player, ActiveMatch;

part 'responses.g.dart';

@JsonSerializable()
class LowerSearch {
  final String name;
  final String playerId;
  final String isPrivate;
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
  final Player playerData;

  SearchPlayersResponse({
    required this.searchData,
    required this.exactMatch,
    required this.playerData,
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
class PlayerStatusResponse {
  final String status;
  final ActiveMatch? match;

  PlayerStatusResponse({required this.status, required this.match});

  factory PlayerStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$PlayerStatusResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerStatusResponseToJson(this);
}

@JsonSerializable()
class FriendsListResponse {
  final List<Player> friends;

  FriendsListResponse({required this.friends});

  factory FriendsListResponse.fromJson(Map<String, dynamic> json) =>
      _$FriendsListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FriendsListResponseToJson(this);
}

@JsonSerializable()
class FavouriteFriendResponse {
  final List<String> favouriteFriends;

  FavouriteFriendResponse({required this.favouriteFriends});

  factory FavouriteFriendResponse.fromJson(Map<String, dynamic> json) =>
      _$FavouriteFriendResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FavouriteFriendResponseToJson(this);
}
