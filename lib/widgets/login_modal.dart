import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/google_button.dart';

void showLoginModal(data_classes.ShowLoginModalOptions options) {
  showModalBottomSheet(
    elevation: 10,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    context: options.context,
    builder: (_) => _LoginModal(options: options),
  );
}

class _LoginModal extends HookConsumerWidget {
  final data_classes.ShowLoginModalOptions options;

  const _LoginModal({
    required this.options,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final authProvider = ref.read(providers.auth);

    // Variables
    final textTheme = Theme.of(context).textTheme;

    // State
    final isLoggingIn = useState(false);

    // Methods
    final onGoogleSignIn = useCallback(
      () async {
        if (isLoggingIn.value) {
          return;
        }

        isLoggingIn.value = true;

        final loginSuccess = await authProvider.signInWithGoogle();
        if (loginSuccess) {
          // after the user is logged in, send the device fcm token to the server
          final fcmToken = await utilities.Messaging.initMessaging();
          if (fcmToken != null) authProvider.sendFcmToken(fcmToken);

          if (authProvider.user?.playerId == null) {
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(
              context,
              screens.ConnectProfile.routeName,
            );
          } else {
            Navigator.of(context).pop();
            options.onSuccess();
          }
        } else {
          isLoggingIn.value = false;
        }
      },
      [],
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          elevation: 0,
          clipBehavior: Clip.hardEdge,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      'LOGIN REQUIRED',
                      style: textTheme.headline1?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  options.loginCta,
                  style: textTheme.bodyText1?.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  'To experience all features of Paladins Edge, please login',
                  style: textTheme.bodyText1?.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        GoogleButton(
          isLoggingIn: isLoggingIn.value,
          onGoogleSignIn: onGoogleSignIn,
        ),
      ],
    );
  }
}
