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
    return Settings(
      showUserPlayerMatches: fields[1] == null ? false : fields[1] as bool,
      selectedQueueRegion: fields[2] == null ? 'ALL' : fields[2] as String,
      selectedBottomTabIndex: fields[3] == null ? 0 : fields[3] as int,
      showChampionSplashImage: fields[4] == null ? true : fields[4] as bool,
      autoOpenKeyboardOnSearch: fields[5] == null ? true : fields[5] as bool,
      autoOpenKeyboardOnChampions: fields[6] == null ? true : fields[6] as bool,
    ).._themeMode = fields[0] as int;
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj._themeMode)
      ..writeByte(1)
      ..write(obj.showUserPlayerMatches)
      ..writeByte(2)
      ..write(obj.selectedQueueRegion)
      ..writeByte(3)
      ..write(obj.selectedBottomTabIndex)
      ..writeByte(4)
      ..write(obj.showChampionSplashImage)
      ..writeByte(5)
      ..write(obj.autoOpenKeyboardOnSearch)
      ..writeByte(6)
      ..write(obj.autoOpenKeyboardOnChampions);
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
