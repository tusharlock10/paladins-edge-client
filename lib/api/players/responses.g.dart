// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LowerSearch _$LowerSearchFromJson(Map<String, dynamic> json) => LowerSearch(
      name: json['name'] as String,
      playerId: json['playerId'] as int,
      isPrivate: json['isPrivate'] as bool,
      platform: json['platform'] as String,
    );

Map<String, dynamic> _$LowerSearchToJson(LowerSearch instance) =>
    <String, dynamic>{
      'name': instance.name,
      'playerId': instance.playerId,
      'isPrivate': instance.isPrivate,
      'platform': instance.platform,
    };

SearchData _$SearchDataFromJson(Map<String, dynamic> json) => SearchData(
      lowerSearchList: (json['lowerSearchList'] as List<dynamic>)
          .map((e) => LowerSearch.fromJson(e as Map<String, dynamic>))
          .toList(),
      topSearchList: (json['topSearchList'] as List<dynamic>)
          .map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchDataToJson(SearchData instance) =>
    <String, dynamic>{
      'topSearchList': instance.topSearchList,
      'lowerSearchList': instance.lowerSearchList,
    };

SearchPlayersResponse _$SearchPlayersResponseFromJson(
        Map<String, dynamic> json) =>
    SearchPlayersResponse(
      searchData:
          SearchData.fromJson(json['searchData'] as Map<String, dynamic>),
      exactMatch: json['exactMatch'] as bool,
      playerData: json['playerData'] == null
          ? null
          : Player.fromJson(json['playerData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchPlayersResponseToJson(
        SearchPlayersResponse instance) =>
    <String, dynamic>{
      'searchData': instance.searchData,
      'exactMatch': instance.exactMatch,
      'playerData': instance.playerData,
    };

PlayerDetailResponse _$PlayerDetailResponseFromJson(
        Map<String, dynamic> json) =>
    PlayerDetailResponse(
      player: Player.fromJson(json['player'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerDetailResponseToJson(
        PlayerDetailResponse instance) =>
    <String, dynamic>{
      'player': instance.player,
    };

BatchPlayerDetailsResponse _$BatchPlayerDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    BatchPlayerDetailsResponse(
      players: (json['players'] as List<dynamic>)
          .map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BatchPlayerDetailsResponseToJson(
        BatchPlayerDetailsResponse instance) =>
    <String, dynamic>{
      'players': instance.players,
    };

PlayerStatusResponse _$PlayerStatusResponseFromJson(
        Map<String, dynamic> json) =>
    PlayerStatusResponse(
      playerId: json['playerId'] as int,
      inMatch: json['inMatch'] as bool,
      status: json['status'] as String,
      match: json['match'] == null
          ? null
          : ActiveMatch.fromJson(json['match'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerStatusResponseToJson(
        PlayerStatusResponse instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'inMatch': instance.inMatch,
      'status': instance.status,
      'match': instance.match,
    };

FriendsResponse _$FriendsResponseFromJson(Map<String, dynamic> json) =>
    FriendsResponse(
      friends: (json['friends'] as List<dynamic>)
          .map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FriendsResponseToJson(FriendsResponse instance) =>
    <String, dynamic>{
      'friends': instance.friends,
    };

FavouriteFriendsResponse _$FavouriteFriendsResponseFromJson(
        Map<String, dynamic> json) =>
    FavouriteFriendsResponse(
      favouriteFriends: (json['favouriteFriends'] as List<dynamic>)
          .map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavouriteFriendsResponseToJson(
        FavouriteFriendsResponse instance) =>
    <String, dynamic>{
      'favouriteFriends': instance.favouriteFriends,
    };

UpdateFavouriteFriendResponse _$UpdateFavouriteFriendResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateFavouriteFriendResponse(
      favouriteFriends: (json['favouriteFriends'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UpdateFavouriteFriendResponseToJson(
        UpdateFavouriteFriendResponse instance) =>
    <String, dynamic>{
      'favouriteFriends': instance.favouriteFriends,
    };

SearchHistoryResponse _$SearchHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    SearchHistoryResponse(
      searchHistory: (json['searchHistory'] as List<dynamic>)
          .map((e) => SearchHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchHistoryResponseToJson(
        SearchHistoryResponse instance) =>
    <String, dynamic>{
      'searchHistory': instance.searchHistory,
    };

PlayerInferredResponse _$PlayerInferredResponseFromJson(
        Map<String, dynamic> json) =>
    PlayerInferredResponse(
      playerInferred: PlayerInferred.fromJson(
          json['playerInferred'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerInferredResponseToJson(
        PlayerInferredResponse instance) =>
    <String, dynamic>{
      'playerInferred': instance.playerInferred,
    };
