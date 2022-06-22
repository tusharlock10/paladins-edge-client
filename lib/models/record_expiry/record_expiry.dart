import "package:hive/hive.dart";
import "package:paladinsedge/constants.dart"
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
    final now = DateTime.now();
    Duration duration;

    switch (recordName) {
      case RecordExpiryName.champion:
        duration = RecordExpiryDuration.championDuration;
        return now.isAfter(_championsExpiry ?? now.add(duration));

      case RecordExpiryName.searchHistory:
        duration = RecordExpiryDuration.searchHistoryDuration;
        return now.isAfter(_searchHistoryExpiry ?? now.add(duration));

      case RecordExpiryName.bountyStore:
        duration = RecordExpiryDuration.bountyStoreDuration;
        return now.isAfter(_bountyStoreExpiry ?? now.add(duration));

      case RecordExpiryName.playerChampion:
        duration = RecordExpiryDuration.playerChampionDuration;
        return now.isAfter(_playerChampionExpiry ?? now.add(duration));

      case RecordExpiryName.queueTimeline:
        duration = RecordExpiryDuration.queueTimelineDuration;
        return now.isAfter(_queueTimelineExpiry ?? now.add(duration));

      case RecordExpiryName.item:
        duration = RecordExpiryDuration.itemDuration;
        return now.isAfter(_itemExpiry ?? now.add(duration));

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
