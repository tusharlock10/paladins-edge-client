import 'package:hive/hive.dart';
import 'package:paladinsedge/constants.dart' show TypeIds, RecordExpiryData;

part 'record_expiry.g.dart';

// model for storing the exipry date of saved champion, searchHistory, etc. in local db
@HiveType(typeId: TypeIds.recordExpiry)
class RecordExpiry extends HiveObject {
  /// date at which the saved champion record will expire
  @HiveField(0)
  DateTime _championsExpiry;

  /// date at which the saved searchHistory record will expire
  @HiveField(1)
  DateTime _searchHistoryExpiry;

  /// date at which the saved bountyStore record will expire
  @HiveField(2)
  DateTime _bountyStoreExpiry;

  /// date at which the saved playerChampion record will expire
  @HiveField(3)
  DateTime _playerChampionExpiry;

  RecordExpiry()
      : _championsExpiry =
            DateTime.now().add(RecordExpiryData.championDuration),
        _searchHistoryExpiry =
            DateTime.now().add(RecordExpiryData.searchHistoryDuration),
        _bountyStoreExpiry =
            DateTime.now().add(RecordExpiryData.bountyStoreDuration),
        _playerChampionExpiry =
            DateTime.now().add(RecordExpiryData.playerChampionDuration);

  bool isRecordExpired(String recordName) {
    // checks if the provided record is expired
    final now = DateTime.now();

    if (recordName == RecordExpiryData.champion) {
      return now.isAfter(_championsExpiry);
    } else if (recordName == RecordExpiryData.searchHistory) {
      return now.isAfter(_searchHistoryExpiry);
    } else if (recordName == RecordExpiryData.bountyStore) {
      return now.isAfter(_bountyStoreExpiry);
    } else if (recordName == RecordExpiryData.playerChampion) {
      return now.isAfter(_playerChampionExpiry);
    } else {
      return true;
    }
  }

  void renewRecordExpiry(String recordName) {
    // renews the expiry date of a record
    if (recordName == RecordExpiryData.champion) {
      _championsExpiry = DateTime.now().add(RecordExpiryData.championDuration);
    } else if (recordName == RecordExpiryData.searchHistory) {
      _searchHistoryExpiry =
          DateTime.now().add(RecordExpiryData.searchHistoryDuration);
    } else if (recordName == RecordExpiryData.bountyStore) {
      _bountyStoreExpiry =
          DateTime.now().add(RecordExpiryData.bountyStoreDuration);
    } else if (recordName == RecordExpiryData.playerChampion) {
      _playerChampionExpiry =
          DateTime.now().add(RecordExpiryData.playerChampionDuration);
    }
  }
}
