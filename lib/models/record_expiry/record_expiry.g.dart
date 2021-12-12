// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_expiry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecordExpiryAdapter extends TypeAdapter<RecordExpiry> {
  @override
  final int typeId = 12;

  @override
  RecordExpiry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecordExpiry()
      .._championsExpiry = fields[0] as DateTime
      .._searchHistoryExpiry = fields[1] as DateTime;
  }

  @override
  void write(BinaryWriter writer, RecordExpiry obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._championsExpiry)
      ..writeByte(1)
      ..write(obj._searchHistoryExpiry);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecordExpiryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
