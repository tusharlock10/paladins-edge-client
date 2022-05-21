import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/global_chat/global_chat_connection.dart';
import 'package:paladinsedge/screens/global_chat/global_chat_input.dart';
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/theme/index.dart' as theme;
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
    final isGuest = ref.watch(providers.auth.select((_) => _.isGuest));

    // Variables
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final chatTheme =
        isLightTheme ? theme.lightGlobalChatTheme : theme.darkGlobalChatTheme;

    // State
    final isInit = useState(false);
    final lastReadMessageKey = useState<String?>(null);
    final messages = useState<List<types.TextMessage>>([]);
    final playersOnline = useState<Map<String, types.User>>({});
    final connectionState = useState(utilities.ChatConnectionState.unknown);
    final user = useState<types.User>(
      player == null
          ? types.User(id: const Uuid().v4())
          : types.User(
              id: player.playerId,
              imageUrl: player.avatarUrl,
              firstName: player.name,
              metadata: const {
                'typing': false,
              },
            ),
    );

    // Methods
    final initChat = useCallback(
      () async {
        final results = await Future.wait([
          utilities.RealtimeGlobalChat.getMessages(),
          utilities.RealtimeGlobalChat.getPlayersOnline(),
        ]);

        messages.value = results.first as List<types.TextMessage>;
        playersOnline.value = results[1] as Map<String, types.User>;
        lastReadMessageKey.value = messages.value.isNotEmpty
            ? messages.value.first.createdAt.toString()
            : null;
        isInit.value = true;
      },
      [],
    );

    final initPlayerOnline = useCallback(
      (models.Player player) {
        user.value = types.User(
          id: player.playerId,
          imageUrl: player.avatarUrl,
          firstName: player.name,
          metadata: const {
            'typing': false,
          },
        );

        return utilities.RealtimeGlobalChat.connectionListener(
          user: user.value,
          onConnected: () =>
              connectionState.value = utilities.ChatConnectionState.connected,
          onDisconnected: () => connectionState.value =
              utilities.ChatConnectionState.disconnected,
        );
      },
      [],
    );

    final onTyping = useCallback(
      (bool isTyping) {
        user.value = user.value.copyWith(
          metadata: {
            ...?user.value.metadata,
            'typing': isTyping,
          },
        );
        utilities.RealtimeGlobalChat.setPlayer(user.value);
      },
      [],
    );

    final onMessage = useCallback(
      (types.TextMessage message) {
        if (message.author.id != player?.playerId) {
          messages.value = [message, ...messages.value];
        }
      },
      [],
    );

    final onMessageChanged = useCallback(
      (types.TextMessage message) {
        final index = messages.value.indexWhere((_) => _.id == message.id);
        if (index == -1) return;
        messages.value[index] = message;
        messages.value = [...messages.value];
      },
      [],
    );

    final onMessageRemove = useCallback(
      (String id) {
        final index = messages.value.indexWhere((_) => _.id == id);
        if (index == -1) return;
        messages.value.removeAt(index);
        messages.value = [...messages.value];
      },
      [],
    );

    final onPlayerOnline = useCallback(
      (types.User user) {
        playersOnline.value = {...playersOnline.value, user.id: user};
      },
      [],
    );

    final onPlayerOnlineChanged = useCallback(
      (types.User user) {
        playersOnline.value = {...playersOnline.value, user.id: user};
      },
      [],
    );

    final onPlayerOnlineRemove = useCallback(
      (String id) {
        playersOnline.value.remove(id);
        playersOnline.value = {...playersOnline.value};
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

    final void Function(String) onSendPressed = useCallback(
      (text) async {
        if (isGuest) return;

        // create a message with status = sending
        var message = types.TextMessage(
          text: text,
          author: user.value,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          status: types.Status.sending,
        );

        // add this message in messages
        messages.value = [message, ...messages.value];

        // set status = sent and deliver the message
        message =
            message.copyWith(status: types.Status.sent) as types.TextMessage;
        final isSuccessful = await utilities.RealtimeGlobalChat.sendMessage(
          message,
        );

        if (!isSuccessful) {
          // if cannot send message, change status to error
          message = message.copyWith(
            status: types.Status.error,
          ) as types.TextMessage;
        }

        final messageIndex = messages.value.indexWhere(
          (_) => _.id == message.id,
        );
        messages.value[messageIndex] = message;
        messages.value = [...messages.value];
      },
      [],
    );

    // Effects
    useEffect(
      () {
        // initialize when not init
        if (!isInit.value) {
          initChat();
        }

        return null;
      },
      [isInit.value],
    );

    useEffect(
      () {
        //
        if (lastReadMessageKey.value == null) return null;

        // pass the lastReadMessageKey to start listening from that point
        final messageListener = utilities.RealtimeGlobalChat.messageListener(
          lastReadMessageKey.value!,
          onMessage,
        );
        final messageChangedListener =
            utilities.RealtimeGlobalChat.messageChangedListener(
          onMessageChanged,
        );
        final messageRemoveListener =
            utilities.RealtimeGlobalChat.messageRemoveListener(
          onMessageRemove,
        );
        final playersOnlineListener =
            utilities.RealtimeGlobalChat.playersOnlineListener(
          onPlayerOnline,
        );
        final playersOnlineChangedListener =
            utilities.RealtimeGlobalChat.playersOnlineChangedListener(
          onPlayerOnlineChanged,
        );
        final playersOnlineRemoveListener =
            utilities.RealtimeGlobalChat.playersOnlineRemoveListener(
          onPlayerOnlineRemove,
        );

        return () async {
          final futures = [
            messageListener,
            messageChangedListener,
            messageRemoveListener,
            playersOnlineListener,
            playersOnlineChangedListener,
            playersOnlineRemoveListener,
          ].mapNotNull((_) => _?.cancel());
          await Future.wait(futures);
          utilities.RealtimeGlobalChat.disconnect();
        };
      },
      [lastReadMessageKey.value],
    );

    useEffect(
      () {
        if (player != null) {
          final connectionListener = initPlayerOnline(player);

          return () {
            connectionListener.cancel();
          };
        }

        return null;
      },
      [player],
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text('Chat'),
            Text(
              playersOnline.value.isEmpty
                  ? 'No one online'
                  : playersOnline.value.length == 1
                      ? 'Only you are online'
                      : '${playersOnline.value.length} players online',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          GlobalChatConnection(
            connectionState: connectionState.value,
          ),
        ],
      ),
      body: !isInit.value
          ? const widgets.LoadingIndicator(
              lineWidth: 1.5,
              size: 28,
              label: Text('Getting messages'),
            )
          : Chat(
              messages: messages.value,
              showUserAvatars: true,
              showUserNames: true,
              user: user.value,
              onSendPressed: (_) => 0,
              onAvatarTap: onAvatarTap,
              hideBackgroundOnEmojiMessages: false,
              emojiEnlargementBehavior: EmojiEnlargementBehavior.single,
              customBottomWidget: isGuest
                  ? const Text('Login to send messages')
                  : GlobalChatInput(
                      user: user.value,
                      playersOnline: playersOnline.value,
                      onSendPressed: onSendPressed,
                      onTyping: onTyping,
                    ),
              theme: chatTheme,
            ),
    );
  }

  static GlobalChat _routeBuilder(_, __) => const GlobalChat();
}
