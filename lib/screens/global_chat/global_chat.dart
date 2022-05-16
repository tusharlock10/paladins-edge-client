import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/theme/index.dart' as app_theme;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;
import 'package:uuid/uuid.dart';

class GlobalChat extends HookConsumerWidget {
  static const routeName = 'globalChat';
  static const routePath = 'globalChat';
  static final goRoute = GoRoute(
    name: routeName,
    path: routePath,
    builder: _routeBuilder,
    redirect: utilities.Navigation.protectedRouteRedirect,
  );
  const GlobalChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final player = ref.watch(providers.auth.select((_) => _.player));

    // Variables
    final theme = Theme.of(context);

    // State
    final user = useState<types.User?>(null);
    final _messages = useState<List<types.TextMessage>>([]);

    // Methods
    final initMessages = useCallback(
      () async {
        if (!constants.isWeb) return null;
        _messages.value = await utilities.RealtimeGlobalChat.readAllMessages();
      },
      [],
    );

    final onMessage = useCallback(
      (types.TextMessage message) {
        _messages.value = [message, ..._messages.value];
      },
      [],
    );

    final onAvatarTap = useCallback(
      (types.User author) {
        utilities.Navigation.navigate(
          context,
          screens.PlayerDetail.routeName,
          params: {
            'playerId': author.id,
          },
        );
      },
      [],
    );

    final onMessageTap = useCallback(
      (BuildContext context, types.Message message) {
        final author = message.author;
        utilities.Navigation.navigate(
          context,
          screens.PlayerDetail.routeName,
          params: {
            'playerId': author.id,
          },
        );
      },
      [],
    );

    final onSendPressed = useCallback(
      (types.PartialText partialMessage) {
        if (user.value == null) return;

        final message = types.TextMessage(
          author: user.value!,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: partialMessage.text,
        );

        utilities.RealtimeGlobalChat.sendMessage(message);
      },
      [],
    );

    // Effects
    useEffect(
      () {
        initMessages();
        final listener = utilities.RealtimeGlobalChat.listenData(onMessage);

        return listener.cancel;
      },
      [],
    );

    useEffect(
      () {
        if (player != null) {
          user.value = types.User(
            id: player.playerId,
            imageUrl: player.avatarUrl,
            firstName: player.name,
          );
        }

        return;
      },
      [player],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Global Chat'),
      ),
      body: user.value == null
          ? const SizedBox()
          : Chat(
              messages: _messages.value,
              showUserAvatars: true,
              showUserNames: true,
              onSendPressed: onSendPressed,
              user: user.value!,
              onAvatarTap: onAvatarTap,
              onMessageTap: onMessageTap,
              emptyState: const widgets.LoadingIndicator(
                lineWidth: 1.5,
                size: 28,
                label: Text('Getting messages'),
              ),
              theme: DefaultChatTheme(
                primaryColor: app_theme.darkThemeMaterialColor.shade50,
                inputBackgroundColor: app_theme.darkThemeMaterialColor.shade300,
                inputBorderRadius: const BorderRadius.all(Radius.circular(10)),
                backgroundColor: app_theme.darkThemeMaterialColor.shade500,
                secondaryColor: app_theme.darkThemeMaterialColor.shade300,
                inputMargin: const EdgeInsets.all(10),
                sendButtonIcon: const Icon(
                  FeatherIcons.cornerDownLeft,
                  size: 20,
                ),
              ),
            ),
    );
  }

  static GlobalChat _routeBuilder(_, __) => const GlobalChat();
}
