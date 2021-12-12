import 'package:hive/hive.dart';
import 'package:paladinsedge/constants.dart' show TypeIds;

part 'search_history.g.dart';

// model for storing user user's searchHistory locally
@HiveType(typeId: TypeIds.searchHistory)
class SearchHistory extends HiveObject {
  /// name of the player searched
  @HiveField(0)
  final String playerName;

  /// date at which the search was ran
  @HiveField(1)
  final DateTime date;

  SearchHistory({
    required this.playerName,
    DateTime? date,
  }) : date = date ?? DateTime.now();
}
