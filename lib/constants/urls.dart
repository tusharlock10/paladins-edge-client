abstract class Urls {
  // root
  static const root = "/";

  // auth
  static const login = "/auth/login"; // POST
  static const logout = "/auth/logout"; // POST
  static const checkPlayerClaimed = "/auth/checkPlayerClaimed"; // GET
  static const claimPlayer = "/auth/claimPlayer"; // POST
  static const fcmToken = "/auth/fcmToken"; // POST
  static const essentials = "/auth/essentials"; // GET
  static const faqs = "/auth/faqs"; // GET
  static const savedMatches = "/auth/savedMatches"; // GET
  static const updateSavedMatches = "/auth/updateSavedMatches"; // PUT
  static const deviceDetail = "/auth/deviceDetail"; // PUT
  static const apiStatus = "/auth/apiStatus"; // GET

  // champions
  static const allChampions = "/champions/allChampions"; // GET
  static const playerChampions = "/champions/playerChampions"; // GET
  static const batchPlayerChampions = "/champions/batchPlayerChampions"; // POST
  static const favouriteChampions = "/champions/favouriteChampions"; // GET
  static const updateFavouriteChampion =
      "/champions/updateFavouriteChampion"; // PUT

  // players
  static const searchPlayers = "/players/searchPlayers"; // GET
  static const playerDetail = "/players/playerDetail"; // GET
  static const batchPlayerDetails = "/players/batchPlayerDetails"; // POST
  static const playerStatus = "/players/playerStatus"; // GET
  static const friends = "/players/friends"; // GET
  static const favouriteFriends = "/players/favouriteFriends"; // GET
  static const updateFavouriteFriend = "/players/updateFavouriteFriend"; // PUT
  static const searchHistory = "/players/searchHistory"; // GET
  static const playerInferred = "/players/playerInferred"; // GET

  // queue
  static const queueTimeline = "/queue/queueTimeline"; // GET

  // bountyStore
  static const bountyStoreDetails = "/bountyStore/bountyStoreDetails"; // GET

  // items
  static const itemDetails = "/items/itemDetails"; // GET

  // match
  static const matchDetails = "/match/matchDetails"; // GET
  static const playerMatches = "/match/playerMatches"; // GET
  static const commonMatches = "/match/commonMatches"; // POST
  static const topMatches = "/match/topMatches"; // GET

  // loadout
  static const playerLoadouts = "/loadout/playerLoadouts"; // GET
  static const savePlayerLoadout = "/loadout/savePlayerLoadout"; // POST
  static const updatePlayerLoadout = "/loadout/updatePlayerLoadout"; // PUT
  static const deletePlayerLoadout = "/loadout/deletePlayerLoadout"; // DELETE

  // feedback
  static const submitFeedback = "/feedback/submitFeedback"; // POST
  static const uploadImageUrl = "/feedback/uploadImageUrl"; // GET
}
