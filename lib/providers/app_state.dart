import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;

class _AppStateNotifier extends ChangeNotifier {
  int bottomTabIndex = 0;
  bool searchTabVisited = false;
  models.Settings settings = models.Settings();

  /// Change index to the current bottom tab
  void setBottomTabIndex(int index) {
    bottomTabIndex = index;
    notifyListeners();
  }

  /// Set wether the search tab is visited or not
  void setSearchTabVisited(bool isVisited) {
    searchTabVisited = isVisited;
    utilities.postFrameCallback(notifyListeners);
  }

  /// Loads the `settings` from local db
  void loadSettings() {
    settings = utilities.Database.getSettings();
    notifyListeners();
  }

  /// Toggle the theme from `light` to `dark` and vice versa
  void toggleTheme(ThemeMode themeMode) {
    settings.themeMode = themeMode;

    String? themeName;
    if (themeMode == ThemeMode.dark) {
      themeName = "dark";
    } else if (themeMode == ThemeMode.light) {
      themeName = "light";
    } else if (themeMode == ThemeMode.system) {
      themeName = "system";
    }
    notifyListeners();
    utilities.Analytics.logEvent(
      constants.AnalyticsEvent.changeTheme,
      {"theme": themeName},
    );
    utilities.Database.saveSettings(settings);
  }

  /// Toggle showUserPlayerMatches for commonMatches
  void toggleShowUserPlayerMatches(bool? value) {
    settings.showUserPlayerMatches = value ?? false;
    notifyListeners();
    utilities.Database.saveSettings(settings);
  }

  /// Set queue region in settings
  void setQueueRegions(String region) {
    settings.selectedQueueRegion = region;
    notifyListeners();
    utilities.Database.saveSettings(settings);
  }

  void clearData() {
    settings = models.Settings();
  }
}

/// Provider to handle app_state
final appState = ChangeNotifierProvider((_) => _AppStateNotifier());
