import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
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

    // State
    final isInit = useState(false);
    final lastReadMessageKey = useState<String?>(null);
    final messages = useState<List<types.TextMessage>>([]);
    final user = useState<types.User>(
      player == null
          ? types.User(id: const Uuid().v4())
          : types.User(
              id: player.playerId,
              imageUrl: utilities.getSmallAsset(player.avatarUrl),
              firstName: player.name,
            ),
    );

    // Methods
    final initMessages = useCallback(
      () async {
        final _messages = await utilities.RealtimeGlobalChat.getMessages();

        messages.value = _messages;
        lastReadMessageKey.value =
            _messages.isNotEmpty ? _messages.first.createdAt.toString() : null;
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

        return utilities.RealtimeGlobalChat.connectionListener(user.value);
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

    final onSendPressed = useCallback(
      (types.PartialText partialMessage) async {
        if (isGuest) return;

        // create a message with status = sending
        var message = types.TextMessage.fromPartial(
          partialText: partialMessage,
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
        final isSuccessful =
            await utilities.RealtimeGlobalChat.sendMessage(message);
        await Future.delayed(const Duration(seconds: 2));

        if (!isSuccessful) {
          message =
              message.copyWith(status: types.Status.error) as types.TextMessage;
        }

        // find the messageIndex from messages
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
          initMessages();
        }

        return null;
      },
      [isInit.value],
    );

    useEffect(
      () {
        if (lastReadMessageKey.value == null) return null;

        // pass the lastReadMessageKey to start listening from that point
        final listener = utilities.RealtimeGlobalChat.messageListener(
          lastReadMessageKey.value!,
          onMessage,
        );
        if (listener != null) return listener.cancel;

        return null;
      },
      [lastReadMessageKey.value],
    );

    useEffect(
      () {
        if (player != null) {
          final connectionListener = initPlayerOnline(player);

          return () {
            connectionListener.cancel();
            utilities.RealtimeGlobalChat.disconnect();
          };
        }

        return null;
      },
      [player],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Global Chat'),
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
              onSendPressed: onSendPressed,
              user: user.value,
              onAvatarTap: onAvatarTap,
              hideBackgroundOnEmojiMessages: false,
              emojiEnlargementBehavior: EmojiEnlargementBehavior.single,
              customBottomWidget:
                  isGuest ? const Text('Login to send messages') : null,
              theme: isLightTheme
                  ? theme.lightGlobalChatTheme
                  : theme.darkGlobalChatTheme,
            ),
    );
  }

  static GlobalChat _routeBuilder(_, __) => const GlobalChat();
}
