// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LowerSearch _$LowerSearchFromJson(Map<String, dynamic> json) => LowerSearch(
      name: json['name'] as String,
      playerId: json['playerId'] as String,
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

PlayerStatusResponse _$PlayerStatusResponseFromJson(
        Map<String, dynamic> json) =>
    PlayerStatusResponse(
      status: json['status'] as String,
      match: json['match'] == null
          ? null
          : ActiveMatch.fromJson(json['match'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerStatusResponseToJson(
        PlayerStatusResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'match': instance.match,
    };

FriendsListResponse _$FriendsListResponseFromJson(Map<String, dynamic> json) =>
    FriendsListResponse(
      friends: (json['friends'] as List<dynamic>)
          .map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FriendsListResponseToJson(
        FriendsListResponse instance) =>
    <String, dynamic>{
      'friends': instance.friends,
    };

FavouriteFriendResponse _$FavouriteFriendResponseFromJson(
        Map<String, dynamic> json) =>
    FavouriteFriendResponse(
      favouriteFriends: (json['favouriteFriends'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$FavouriteFriendResponseToJson(
        FavouriteFriendResponse instance) =>
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
