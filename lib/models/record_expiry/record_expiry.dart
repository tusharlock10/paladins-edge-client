import 'package:hive/hive.dart';
import 'package:paladinsedge/constants.dart' show TypeIds, RecordExpiryData;

part 'record_expiry.g.dart';

// model for storing the exipry date of saved champion, searchHistory, etc. in local db
@HiveType(typeId: TypeIds.recordExpiry)
class RecordExpiry extends HiveObject {
  // date at which the saved champion record will expire
  @HiveField(0)
  DateTime _championsExpiry;
  // date at which the saved searchHistory record will expire
  @HiveField(1)
  DateTime _searchHistoryExpiry;

  RecordExpiry()
      : _championsExpiry = DateTime.now().add(RecordExpiryData.championDuation),
        _searchHistoryExpiry =
            DateTime.now().add(RecordExpiryData.searchHistoryDuation);

  bool isRecordExpired(String recordName) {
    // checks if the provided record is expired
    final now = DateTime.now();

    if (recordName == RecordExpiryData.champion) {
      return now.isAfter(_championsExpiry);
    } else if (recordName == RecordExpiryData.searchHistory) {
      return now.isAfter(_searchHistoryExpiry);
    } else {
      return true;
    }
  }

  void renewRecordExpiry(String recordName) {
    // renews the expiry date of a record
    if (recordName == RecordExpiryData.champion) {
      _championsExpiry = DateTime.now().add(RecordExpiryData.championDuation);
    } else if (recordName == RecordExpiryData.searchHistory) {
      _searchHistoryExpiry =
          DateTime.now().add(RecordExpiryData.searchHistoryDuation);
    }
  }
}
