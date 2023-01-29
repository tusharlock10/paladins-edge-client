abstract class Urls {
  // root
  static const root = "/";

  // auth
  static const login = "/auth/login"; // POST
  static const logout = "/auth/logout"; // POST
  static const checkPlayerClaimed = "/auth/checkPlayerClaimed/:playerId"; // GET
  static const claimPlayer = "/auth/claimPlayer"; // POST
  static const faqs = "/auth/faqs"; // GET
  static const deviceDetail = "/auth/deviceDetail"; // PUT

  // common
  static const essentials = "/common/essentials"; // GET
  static const bountyStore = "/common/bountyStore"; // GET
  static const items = "/common/items"; // GET

  // champions
  static const champions = "/champions"; // GET
  static const playerChampions = "/champions/playerChampions"; // GET
  static const batchPlayerChampions = "/champions/batchPlayerChampions"; // POST
  static const favouriteChampions = "/champions/favourite"; // GET
  static const updateFavouriteChampion =
      "/champions/updateFavouriteChampion"; // PUT

  // players
  static const searchPlayers = "/players/search/:playerName"; // GET
  static const playerDetail = "/players/playerDetail"; // GET
  static const batchPlayerDetails = "/players/batchPlayerDetails"; // POST
  static const playerStatus = "/players/playerStatus"; // GET
  static const friends = "/players/friends"; // GET
  static const favouriteFriends = "/players/favourite"; // GET
  static const updateFavouriteFriend = "/players/updateFavouriteFriend"; // PUT
  static const searchHistory = "/players/searchHistory"; // GET
  static const playerInferred = "/players/playerInferred"; // GET

  // queue
  static const queueTimeline = "/queue/timeline"; // GET

  // matches
  static const matchDetails = "/match/matchDetails"; // GET
  static const playerMatches = "/match/playerMatches"; // GET
  static const commonMatches = "/match/commonMatches"; // POST
  static const savedMatches = "/matches/saved"; // GET
  static const saveMatch = "/matches/save/:matchId"; // PUT
  static const topMatches = "/matches/top"; // GET

  // loadout
  static const playerLoadouts = "/loadout/playerLoadouts"; // GET
  static const savePlayerLoadout = "/loadout/savePlayerLoadout"; // POST
  static const updatePlayerLoadout = "/loadout/updatePlayerLoadout"; // PUT
  static const deletePlayerLoadout = "/loadout/deletePlayerLoadout"; // DELETE

  // feedback
  static const submitFeedback = "/feedback/submitFeedback"; // POST
  static const uploadImageUrl = "/feedback/uploadImageUrl"; // GET
}
