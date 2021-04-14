import 'package:flutter/foundation.dart';

import '../Utilities/index.dart' as Utilities;
import '../Models/Champion.dart' as Models;
import '../Constants.dart' as Constants;

class Champions with ChangeNotifier {
  List<Models.Champion> _champions = [];

  Champions();

  List<Models.Champion> get champions {
    return this._champions;
  }

  Future<void> fetchChampions() async {
    final response = await Utilities.api.get(Constants.URLS.champions);
    final data = response.data as List<dynamic>;
    final champions =
        data.map((jsonMap) => Models.Champion.fromJson(jsonMap)).toList();
    this._champions = champions;
    notifyListeners();
    return;
  }
}
