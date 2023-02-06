abstract class Urls {
  // root
  static const root = "/";

  // auth
  static const login = "/auth/login"; // POST
  static const logout = "/auth/logout"; // POST
  static const claimPlayer = "/auth/claim/player"; // POST
  static const checkPlayerClaimed = "/auth/claim/check/:playerId"; // GET
  static const registerDevice = "/auth/device/register"; // PUT

  // common
  static const essentials = "/common/essentials"; // GET
  static const bountyStore = "/common/bounty"; // GET
  static const items = "/common/items"; // GET
  static const faq = "/common/faq"; // GET
  static const feedback = "/common/feedback"; // POST

  // champions
  static const champions = "/champions"; // GET
  static const playerChampions = "/champions/player/:playerId"; // GET
  static const batchPlayerChampions = "/champions/player/batch"; // POST
  static const favouriteChampions = "/champions/favourite"; // GET
  static const markFavouriteChampion =
      "/champions/favourite/:championId"; // POST

  // players
  static const searchPlayers = "/players/search/:playerName"; // GET
  static const player = "/players/:playerId"; // GET
  static const batchPlayer = "/players/batchPlayerDetails"; // POST
  static const playerStatus = "/players/status/:playerId"; // GET
  static const friends = "/players/friends/:playerId"; // GET
  static const favouriteFriends = "/players/favourite"; // GET
  static const markFavouriteFriend = "/players/favourite/:playerId"; // POST
  static const playerInferred = "/players/inferred/:playerId"; // GET

  // queue
  static const queueTimeline = "/queue/timeline"; // GET

  // matches
  static const matchDetails = "/matches/:matchId"; // GET
  static const playerMatches = "/matches/player/:playerId"; // GET
  static const commonMatches = "/matches/common"; // GET
  static const savedMatches = "/matches/saved"; // GET
  static const saveMatch = "/matches/save/:matchId"; // PUT
  static const topMatches = "/matches/top"; // GET

  // loadouts
  static const playerLoadouts = "/loadouts/player/:playerId"; // GET
  static const createLoadout = "/loadouts/create"; // POST
  static const updateLoadout = "/loadouts/update"; // PUT
  static const deleteLoadout = "/loadouts/:loadoutHash"; // DELETE

  // user
  static const searchHistory = "/user/search/history"; // GET
}
