// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchPlayersResponse _$SearchPlayersResponseFromJson(
        Map<String, dynamic> json) =>
    SearchPlayersResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: json['data'] == null
          ? null
          : SearchPlayersData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchPlayersResponseToJson(
        SearchPlayersResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
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
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavouriteFriendsResponseToJson(
        FavouriteFriendsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
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
