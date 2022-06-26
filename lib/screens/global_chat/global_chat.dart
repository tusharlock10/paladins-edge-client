import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_chat_types/flutter_chat_types.dart" as types;
import "package:flutter_chat_ui/flutter_chat_ui.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/global_chat/global_chat_connection.dart";
import "package:paladinsedge/screens/global_chat/global_chat_input.dart";
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class GlobalChat extends HookConsumerWidget {
  static const routeName = "globalChat";
  static const routePath = "globalChat";
  static final goRoute = GoRoute(
    name: routeName,
    path: routePath,
    pageBuilder: _routeBuilder,
    redirect: utilities.Navigation.protectedRouteRedirect,
  );
  const GlobalChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final globalChatProvider = ref.read(providers.globalChat);
    final isGuest = ref.watch(providers.auth.select((_) => _.isGuest));
    final connectionState =
        ref.watch(providers.globalChat.select((_) => _.connectionState));
    final isInit = ref.watch(providers.globalChat.select((_) => _.isInit));
    final messages = ref.watch(providers.globalChat.select((_) => _.messages));
    final globalChatUser =
        ref.watch(providers.globalChat.select((_) => _.globalChatUser));
    final playersOnline =
        ref.watch(providers.globalChat.select((_) => _.playersOnline));

    // Variables
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final chatTheme =
        isLightTheme ? theme.lightGlobalChatTheme : theme.darkGlobalChatTheme;

    // Methods
    final onAvatarTap = useCallback(
      (types.User author) {
        utilities.Navigation.navigate(
          context,
          screens.PlayerDetail.routeName,
          params: {
            "playerId": author.id,
          },
        );
      },
      [],
    );

    // Effects
    useEffect(
      () {
        globalChatProvider.initialize();

        return null;
      },
      [],
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text("Chat"),
            Text(
              playersOnline.isEmpty
                  ? "No one online"
                  : playersOnline.length == 1
                      ? "Only you are online"
                      : "${playersOnline.length} players online",
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          GlobalChatConnection(
            connectionState: connectionState,
          ),
        ],
      ),
      body: !isInit
          ? const widgets.LoadingIndicator(
              lineWidth: 1.5,
              size: 28,
              label: Text("Getting messages"),
            )
          : Chat(
              messages: messages,
              showUserAvatars: true,
              showUserNames: true,
              user: globalChatUser,
              onSendPressed: (_) => 0,
              onAvatarTap: onAvatarTap,
              hideBackgroundOnEmojiMessages: false,
              emojiEnlargementBehavior: EmojiEnlargementBehavior.single,
              customBottomWidget: isGuest
                  ? const SizedBox()
                  : GlobalChatInput(
                      onSendPressed: globalChatProvider.sendNewMessage,
                      onTyping: globalChatProvider.sendTypingMetadata,
                    ),
              theme: chatTheme,
            ),
    );
  }

  static Page _routeBuilder(_, __) => const CupertinoPage(child: GlobalChat());
}
