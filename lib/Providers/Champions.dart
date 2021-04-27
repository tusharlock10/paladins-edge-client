import 'package:flutter/foundation.dart';

import '../Utilities/index.dart' as Utilities;
import '../Models/Champion.dart' as Models;
import '../Constants.dart' as Constants;

class Champions with ChangeNotifier {
  List<Models.Champion> champions = [];

  Champions();

  Future<void> fetchChampions() async {
    final response = await Utilities.api.get(Constants.Urls.allChampions);
    final data = response.data as List<dynamic>;
    this.champions =
        data.map((jsonMap) => Models.Champion.fromJson(jsonMap)).toList();
    notifyListeners();
  }
}
