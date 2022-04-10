import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:paladinsedge/models/index.dart' show Champion, PlayerChampion;

part 'combined_champion.freezed.dart';

@freezed
class CombinedChampion with _$CombinedChampion {
  factory CombinedChampion({
    required Champion champion,
    PlayerChampion? playerChampion,
    @Default(false) bool hide, // used for filtering
  }) = _CombinedChampion;
}
