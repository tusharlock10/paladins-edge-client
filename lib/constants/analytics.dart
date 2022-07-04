abstract class AnalyticsEvent {
  // app events
  static const appInitialized = "app_initialized";

  // screen change events
  static const screenView = "screen_view";
  static const tabChange = "tab_change";

  // login events
  static const newUserLogin = "new_user_login";
  static const existingUserLogin = "existing_user_login";
  static const guestLogin = "guest_login";
  static const claimProfile = "claim_profile";
  static const guestToUserConversion = "guest_to_user_conversion";

  // navigation drawer events
  static const changeTheme = "change_theme";
  static const userLogout = "user_logout";
  static const guestLogout = "guest_logout";

  // friends
  static const markFriend = "mark_friend";
  static const unmarkFriend = "unmark_friend";

  // search player
  static const searchPlayer = "search_player";
  static const clickSearchHistory = "click_search_history";

  // player detail
  static const otherPlayerActiveMatch = "other_player_active_match";
  static const otherPlayerFriends = "other_player_friends";
  static const otherPlayerChampions = "other_player_champions";
  static const playerMatchesFilterSort = "player_matches_filter_sort";

  // other player champions
  static const otherPlayerViewLoadout = "other_player_view_loadout";

  // champions
  static const directSearchChampion = "direct_search_champion";
  static const championsFilterSort = "champions_filter_sort";
  static const championLoadouts = "champion_loadouts";
  static const createChampionLoadout = "create_champion_loadout";
}
