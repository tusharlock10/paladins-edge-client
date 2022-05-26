import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:paladinsedge/models/index.dart' show Champion, PlayerChampion;

part 'combined_champion.freezed.dart';

enum ChampionsSearchCondition {
  name,
  championId,
  title,
  role,
  level,
}


@freezed
class CombinedChampion with _$CombinedChampion {
  factory CombinedChampion({
    required Champion champion,
    PlayerChampion? playerChampion,
    @Default(false) bool hide, // used for filtering
    @Default(null)
        ChampionsSearchCondition? searchCondition, // used for searching
  }) = _CombinedChampion;
}
