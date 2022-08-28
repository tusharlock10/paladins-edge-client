// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsAdapter extends TypeAdapter<Settings> {
  @override
  final int typeId = 7;

  @override
  Settings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Settings()
      ..showUserPlayerMatches = fields[1] == null ? false : fields[1] as bool
      .._themeMode = fields[0] as int;
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.showUserPlayerMatches)
      ..writeByte(0)
      ..write(obj._themeMode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
