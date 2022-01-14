import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/widgets/drawer/player_profile.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class AppDrawer extends HookConsumerWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // State
    final isLoggingOut = useState(false);

    // Methods
    final onLogout = useCallback(
      (BuildContext context, WidgetRef ref) async {
        isLoggingOut.value = true;
        await ref.read(providers.auth).logout();
        Navigator.pushReplacementNamed(context, screens.Login.routeName);
        isLoggingOut.value = false;
      },
      [],
    );

    final onChangeTheme = useCallback(
      (BuildContext context, WidgetRef ref) {
        final authProvider = ref.read(providers.auth);

        if (authProvider.settings.themeMode == ThemeMode.dark) {
          authProvider.toggleTheme(ThemeMode.light);
        } else if (authProvider.settings.themeMode == ThemeMode.light) {
          authProvider.toggleTheme(ThemeMode.dark);
        } else {
          final brightness = Theme.of(context).brightness;
          authProvider.toggleTheme(
            brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark,
          );
        }
      },
      [],
    );

    final onFriends = useCallback(
      (BuildContext context) {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(screens.Friends.routeName);
      },
      [],
    );

    final onActiveMatch = useCallback(
      (BuildContext context) {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(screens.ActiveMatch.routeName);
      },
      [],
    );

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const PlayerProfile(),
            _DrawerButton(
              context: context,
              label: 'Change Theme',
              onPressed: () => onChangeTheme(context, ref),
            ),
            _DrawerButton(
              context: context,
              label: 'Friends',
              onPressed: () => onFriends(context),
            ),
            _DrawerButton(
              context: context,
              label: 'Active Match',
              onPressed: () => onActiveMatch(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLoggingOut.value
                    ? const widgets.LoadingIndicator(
                        size: 16,
                        lineWidth: 2,
                      )
                    : const SizedBox(),
                _DrawerButton(
                  context: context,
                  label: 'Logout',
                  disabled: isLoggingOut.value,
                  onPressed: () => onLogout(context, ref),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  final BuildContext context;
  final String label;
  final bool disabled;
  final void Function() onPressed;

  const _DrawerButton({
    Key? key,
    required this.context,
    required this.label,
    required this.onPressed,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      onPressed: disabled ? null : onPressed,
      child: Text(
        label,
        style: theme.textTheme.headline3
            ?.copyWith(color: theme.colorScheme.secondary),
      ),
    );
  }
}
