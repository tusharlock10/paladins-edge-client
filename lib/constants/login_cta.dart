abstract class LoginCTA {
  static final friendsDrawer =
      """Friends section allows you to view your in-game friend list,
mark your friends as favorites"""
          .replaceAll("\n", " ");

  static final activeMatchDrawer = """Active Match section allows you to
view your live match,
check stats of all the players before loading in
and visit their profile directly
"""
      .replaceAll("\n", " ");

  static final loadoutFab = """Loadout section allows you to
view your in-game loadouts,
create and save your own
loadouts outside the game 
"""
      .replaceAll("\n", " ");

  static final globalChat = """Global Chat allows you to send
messages to other players, and start discussions.
"""
      .replaceAll("\n", " ");

  static final savedMatches = """Save Matches feature will allow 
you to save the matches that you like and also lets you view them later.
"""
      .replaceAll("\n", " ");

  static final commonMatches = """Common matches allows you to view
the matches in which you and this player played together, either as allies or foes
"""
      .replaceAll("\n", " ");
}

const loginHelpTextWeb = """Try the following

1. Open an Incognito browser and check https://paladinsedge.app website
2. If the website is loading, follow these steps -
    a. Open paladinsedge.app in browser
    b. Click on the site settings
        (left most icon in url bar, left of paladinsedge.app)
    c. 'Site settings' > 'Delete data'
    d. Reload the website 
3. If the website is not loading, either -
    a. Our servers are down for maintenance
    b. Maybe your internet is not working""";

const loginHelpTextMobile = """Try the following

1. Open an Incognito browser and check https://paladinsedge.app website
2. If the website is loading, uninstall and reinstall the app
3. If the website is not loading, either -
    a. Our servers are down for maintenance
    b. Maybe your internet is not working""";
