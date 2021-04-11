import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import '../Models/Champion.dart' as Models;

class Champions with ChangeNotifier {
  List<Models.Champion> _champions = [];

  Champions();

  List<Models.Champion> get champions {
    return this._champions;
  }

  Future<void> fetchChampions() async {
    final httpClient = Dio(BaseOptions(baseUrl: "http://192.168.0.103:8000/"));
    final response = await httpClient.get('champions');
    final data = response.data as List<dynamic>;
    final champions =
        data.map((jsonMap) => Models.Champion.fromJson(jsonMap)).toList();
    this._champions = champions;
    notifyListeners();
    return;
  }
}
