import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;

class _AppStateNotifier extends ChangeNotifier {
  int bottomTabIndex = 0;
  bool searchTabVisited = false;
  bool championsTabVisited = false;
  models.Settings settings = models.Settings();

  /// Change index to the current bottom tab
  void setBottomTabIndex(int index) {
    bottomTabIndex = index;
    notifyListeners();
  }

  /// Set whether the search tab is visited or not
  void setSearchTabVisited(bool isVisited) {
    searchTabVisited = isVisited;
    utilities.postFrameCallback(notifyListeners);
  }

  /// Set whether the champions tab is visited or not
  void setChampionsTabVisited(bool isVisited) {
    championsTabVisited = isVisited;
    utilities.postFrameCallback(notifyListeners);
  }

  /// Loads the `settings` from local db
  void loadSettings() {
    settings = utilities.Database.getSettings();
    bottomTabIndex = settings.selectedBottomTabIndex;
    searchTabVisited = !settings.autoOpenKeyboardOnSearch;
    championsTabVisited = !settings.autoOpenKeyboardOnChampions;

    notifyListeners();
  }

  /// Set new settings and save them in db
  void setSettings(models.Settings newSettings) {
    settings = newSettings;
    utilities.Database.saveSettings(settings);
    notifyListeners();
  }

  /// Toggle the theme from `light` to `dark` and vice versa
  /// TODO: remove this and use `setSettings`
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
    utilities.Analytics.logEvent(
      constants.AnalyticsEvent.changeTheme,
      {"theme": themeName},
    );
    utilities.Database.saveSettings(settings);
    notifyListeners();
  }

  /// Toggle showUserPlayerMatches for commonMatches
  /// TODO: remove this and use `setSettings`
  void toggleShowUserPlayerMatches(bool? value) {
    settings.showUserPlayerMatches = value ?? false;
    utilities.Database.saveSettings(settings);
    notifyListeners();
  }

  /// Set queue region in settings
  /// TODO: remove this and use `setSettings`
  void setQueueRegions(String region) {
    settings.selectedQueueRegion = region;
    utilities.Database.saveSettings(settings);
    notifyListeners();
  }

  void clearData() {
    settings = models.Settings();
  }
}

/// Provider to handle app_state
final appState = ChangeNotifierProvider((_) => _AppStateNotifier());
