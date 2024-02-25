import "package:flutter/material.dart" show ThemeMode;
import "package:hive/hive.dart";
import "package:paladinsedge/constants/index.dart" show TypeIds;
import "package:paladinsedge/data_classes/common/region.dart" show Region;
import "package:paladinsedge/data_classes/index.dart" show BottomTabPage;
import "package:paladinsedge/screens/main/main_pages.dart" show pages;

part "settings.g.dart";

const _themeModeMapping = {
  0: ThemeMode.system,
  1: ThemeMode.light,
  2: ThemeMode.dark,
};

final _reverseThemeModeMapping = _themeModeMapping.map(
  (key, value) => MapEntry(value, key),
);

// model for storing user settings locally
@HiveType(typeId: TypeIds.settings)
class Settings extends HiveObject {
  /// initialize _themeMode to the system theme, 0=system, 1=light, 2=dark
  @HiveField(0)
  int _themeMode;

  /// Used to check whether to show other/user playerMatches in commonMatches
  @HiveField(1, defaultValue: false)
  bool showUserPlayerMatches;

  /// Used to store the value of selected queue by user
  @HiveField(2, defaultValue: Region.all)
  String selectedQueueRegion;

  /// Used to select the entry page for main upon startup
  @HiveField(3, defaultValue: 0)
  int selectedBottomTabIndex;

  /// Whether to show the champion splash as background image
  @HiveField(4, defaultValue: true)
  bool showChampionSplashImage;

  /// Whether to open keyboard automatically on search screen
  @HiveField(5, defaultValue: true)
  bool autoOpenKeyboardOnSearch;

  /// Whether to open keyboard automatically on champions screen
  @HiveField(6, defaultValue: true)
  bool autoOpenKeyboardOnChampions;

  Settings({
    int themeMode = 0,
    this.showUserPlayerMatches = false,
    this.selectedQueueRegion = Region.all,
    this.selectedBottomTabIndex = 0,
    this.showChampionSplashImage = true,
    this.autoOpenKeyboardOnSearch = true,
    this.autoOpenKeyboardOnChampions = true,
  }) : _themeMode = themeMode;

  // Getters
  ThemeMode get themeMode => _themeModeMapping[_themeMode]!;
  BottomTabPage get selectedBottomTabData => pages[selectedBottomTabIndex];

  // Setters
  set themeMode(ThemeMode themeMode) => _reverseThemeModeMapping[themeMode];

  // Static methods
  Settings copyWith({
    int? themeMode,
    bool? showUserPlayerMatches,
    String? selectedQueueRegion,
    int? selectedBottomTabIndex,
    bool? showChampionSplashImage,
    bool? autoOpenKeyboardOnSearch,
    bool? autoOpenKeyboardOnChampions,
  }) {
    return Settings(
      themeMode: themeMode ?? _themeMode,
      showUserPlayerMatches:
          showUserPlayerMatches ?? this.showUserPlayerMatches,
      selectedQueueRegion: selectedQueueRegion ?? this.selectedQueueRegion,
      selectedBottomTabIndex:
          selectedBottomTabIndex ?? this.selectedBottomTabIndex,
      showChampionSplashImage:
          showChampionSplashImage ?? this.showChampionSplashImage,
      autoOpenKeyboardOnSearch:
          autoOpenKeyboardOnSearch ?? this.autoOpenKeyboardOnSearch,
      autoOpenKeyboardOnChampions:
          autoOpenKeyboardOnChampions ?? this.autoOpenKeyboardOnChampions,
    );
  }

  // Methods
  /// Gives the next bottomTabIndex in rotation
  int cycleBottomTabIndex() {
    int nextIndex = selectedBottomTabIndex + 1;
    if (nextIndex < pages.length) return nextIndex;

    return 0;
  }
}
