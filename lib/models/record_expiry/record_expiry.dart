import "package:hive/hive.dart";
import "package:paladinsedge/constants/index.dart"
    show TypeIds, RecordExpiryDuration, RecordExpiryName;

part "record_expiry.g.dart";

// model for storing the expiry date of saved champion, searchHistory, etc. in local db
@HiveType(typeId: TypeIds.recordExpiry)
class RecordExpiry extends HiveObject {
  /// date at which the saved champion record will expire
  @HiveField(0)
  DateTime? _championsExpiry;

  /// date at which the saved searchHistory record will expire
  @HiveField(1)
  DateTime? _searchHistoryExpiry;

  /// date at which the saved bountyStore record will expire
  @HiveField(2)
  DateTime? _bountyStoreExpiry;

  /// date at which the saved playerChampion record will expire
  @HiveField(3)
  DateTime? _playerChampionExpiry;

  /// date at which the saved queue record will expire
  @HiveField(4)
  DateTime? _queueTimelineExpiry;

  /// date at which the saved item record will expire
  @HiveField(5)
  DateTime? _itemExpiry;

  bool isRecordExpired(RecordExpiryName recordName) {
    // checks if the provided record is expired
    switch (recordName) {
      case RecordExpiryName.champion:
        return _championsExpiry != null
            ? DateTime.now().isAfter(_championsExpiry!)
            : true;

      case RecordExpiryName.searchHistory:
        return _searchHistoryExpiry != null
            ? DateTime.now().isAfter(_searchHistoryExpiry!)
            : true;

      case RecordExpiryName.bountyStore:
        return _bountyStoreExpiry != null
            ? DateTime.now().isAfter(_bountyStoreExpiry!)
            : true;

      case RecordExpiryName.playerChampion:
        return _playerChampionExpiry != null
            ? DateTime.now().isAfter(_playerChampionExpiry!)
            : true;

      case RecordExpiryName.queueTimeline:
        return _queueTimelineExpiry != null
            ? DateTime.now().isAfter(_queueTimelineExpiry!)
            : true;

      case RecordExpiryName.item:
        return _itemExpiry != null
            ? DateTime.now().isAfter(_itemExpiry!)
            : true;

      default:
        return true;
    }
  }

  void renewRecordExpiry(RecordExpiryName recordName) {
    // renews the expiry date of a record
    switch (recordName) {
      case RecordExpiryName.champion:
        _championsExpiry =
            DateTime.now().add(RecordExpiryDuration.championDuration);
        return;

      case RecordExpiryName.searchHistory:
        _searchHistoryExpiry =
            DateTime.now().add(RecordExpiryDuration.searchHistoryDuration);
        return;

      case RecordExpiryName.bountyStore:
        _bountyStoreExpiry =
            DateTime.now().add(RecordExpiryDuration.bountyStoreDuration);
        return;

      case RecordExpiryName.playerChampion:
        _playerChampionExpiry =
            DateTime.now().add(RecordExpiryDuration.playerChampionDuration);
        return;

      case RecordExpiryName.queueTimeline:
        _queueTimelineExpiry =
            DateTime.now().add(RecordExpiryDuration.queueTimelineDuration);
        return;

      case RecordExpiryName.item:
        _itemExpiry = DateTime.now().add(RecordExpiryDuration.itemDuration);
        return;
    }
  }
}
