// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchHistoryAdapter extends TypeAdapter<SearchHistory> {
  @override
  final int typeId = 11;

  @override
  SearchHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchHistory(
      playerId: fields[0] as String,
      playerName: fields[1] as String,
      time: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SearchHistory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.playerId)
      ..writeByte(1)
      ..write(obj.playerName)
      ..writeByte(2)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchHistory _$SearchHistoryFromJson(Map<String, dynamic> json) =>
    SearchHistory(
      playerId: json['playerId'] as String,
      playerName: json['playerName'] as String,
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$SearchHistoryToJson(SearchHistory instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'playerName': instance.playerName,
      'time': instance.time.toIso8601String(),
    };
