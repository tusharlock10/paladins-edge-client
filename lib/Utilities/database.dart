import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Models/index.dart' as Models;

abstract class Database {
  static Box? _userBox;
  static Box? _searchHistoryBox;

  static Future<void> initDatabase() async {
    await Hive.initFlutter();
    _userBox = await Hive.openBox('user');
    _searchHistoryBox = await Hive.openBox('searchHistory');
  }

  static void setUser(Models.User user) {
    _userBox?.put('user', user.toJson());
  }

  static Models.User? getUser() {
    final json = _userBox?.get('user');
    if (json == null) {
      return null;
    }
    final jsonMap = Map<String, dynamic>.from(json);
    final user = Models.User.fromJson(jsonMap);
    return user;
  }

  static void clear() {
    _userBox?.clear();
    _searchHistoryBox?.clear();
  }

  static void addSearchItem(Map<String, dynamic> searchItem) {
    _searchHistoryBox?.add(searchItem);
  }

  static List<Map<String, dynamic>> getSearchHistory() {
    final json = _searchHistoryBox?.values;
    if (json == null) {
      return [];
    }
    final searchHistory =
        json.map((item) => Map<String, dynamic>.from(item)).toList();
    return searchHistory.reversed.toList();
  }
}
