import "package:freezed_annotation/freezed_annotation.dart";
import "package:paladinsedge/models/index.dart" show Match, MatchPlayer;

part "combined_match.freezed.dart";

@freezed
class CombinedMatch with _$CombinedMatch {
  factory CombinedMatch({
    required Match match,
    required List<MatchPlayer> matchPlayers,
    @Default(false) bool hide, // used for filtering
  }) = _CombinedMatch;
}
