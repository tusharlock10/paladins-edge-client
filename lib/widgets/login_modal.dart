import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/google_button.dart";
import "package:paladinsedge/widgets/toast.dart";

void showLoginModal(data_classes.ShowLoginModalOptions options) {
  final context = options.context;
  final screenWidth = MediaQuery.of(context).size.width;
  final width = utilities.responsiveCondition(
    context,
    desktop: screenWidth / 2.5,
    tablet: screenWidth / 1.5,
    mobile: screenWidth,
  );

  showModalBottomSheet(
    elevation: 10,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    context: context,
    builder: (_) => _LoginModal(width: width, options: options),
    constraints: BoxConstraints(maxWidth: width),
  );
}

class _LoginModal extends HookConsumerWidget {
  final data_classes.ShowLoginModalOptions options;
  final double width;

  const _LoginModal({
    required this.options,
    required this.width,
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
    final goBack = useCallback(
      () {
        utilities.Navigation.pop(context);
      },
      [],
    );

    final onGoogleSignIn = useCallback(
      () async {
        if (isLoggingIn.value) {
          return;
        }

        isLoggingIn.value = true;

        final response = await authProvider.signInWithGoogle();
        if (response.result) {
          goBack();
        } else {
          isLoggingIn.value = false;
          if (response.errorCode == null && response.errorMessage == null) {
            showToast(
              context: context,
              text: response.errorMessage!,
              type: ToastType.error,
              errorCode: response.errorCode,
            );
          }
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
                      "LOGIN REQUIRED",
                      style: textTheme.headline1?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
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
                  "Login to experience all features of Paladins Edge",
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
          onFAQ: null,
          width: width - 30,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
