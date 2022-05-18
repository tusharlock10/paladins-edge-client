import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:paladinsedge/constants.dart' as constants;
import 'package:uuid/uuid.dart';

class RealtimeGlobalChat {
  static final _connectedRef = FirebaseDatabase.instance.ref(".info/connected");
  static DatabaseReference? _globalChatRef;
  static DatabaseReference? _messagesRef;
  static DatabaseReference? _playersOnlineRef;
  static DatabaseReference? _playerRef;

  /// Used to initialize ref object
  /// should be called Env is setup
  static void initialize() {
    _globalChatRef = FirebaseDatabase.instance.ref(
      "${constants.Env.appType}-global-chat",
    );
    _messagesRef = _globalChatRef!.child("messages");
    _playersOnlineRef = _globalChatRef!.child("players-online");
    _keepChatMessagesSynced();
  }

  /// Listens for connection events, initially when GlobalChat screen mounts
  /// user would be connected to RTDB, so [_setPlayerOnline] is called
  /// when user disconnects unintentionally, [_registerDisconnect] is called from db
  /// and player online data is removed from RTDB.
  static StreamSubscription connectionListener(types.User user) {
    return _connectedRef.onValue.listen((event) {
      final connected = event.snapshot.value as bool? ?? false;
      if (connected) _setPlayerOnline(user);
    });
  }

  /// manually remove player online data
  /// called when GlobalChat screen unmounts
  static void disconnect() async {
    if (_playerRef == null) return;
    await _playerRef!.onDisconnect().cancel();
    await _playerRef!.remove();
    _playerRef = null;
  }

  /// read contents of database
  static Future<List<types.TextMessage>> getMessages() async {
    if (_messagesRef == null) return [];

    final snapshot = await _messagesRef!.get();
    if (!snapshot.exists) return [];
    final json = snapshot.value as Map;
    final jsonMessages = json.values;

    return jsonMessages.mapNotNull(_convertSnapshotToMessages).toList();
  }

  /// add listener to database events
  static StreamSubscription? messageListener(
    void Function(types.TextMessage) onEvent,
  ) {
    if (_messagesRef == null) return null;

    return _messagesRef!.onChildAdded.listen(
      (event) {
        if (!event.snapshot.exists) return;
        final message = _convertSnapshotToMessages(event.snapshot.value);
        if (message != null) onEvent(message);
      },
    );
  }

  /// writes some json data to realtime database
  /// returns true if message successfully delivered
  static Future<bool> sendMessage(types.TextMessage data) async {
    if (_messagesRef == null) return false;

    try {
      await _messagesRef!
          .child(const Uuid().v4())
          .set(data.toJson())
          .timeout(const Duration(seconds: 10));

      return true;
    } catch (e) {
      return false;
    }
  }

  /// converts weird fucking crap coming from
  /// firebase into something that makes sense
  static types.TextMessage? _convertSnapshotToMessages(
    Object? snapshotValue,
  ) {
    final data = snapshotValue as Map?;
    if (data == null) return null;

    return types.TextMessage(
      author: types.User(
        id: data["author"]["id"] as String,
        firstName: data["author"]["firstName"] as String?,
        imageUrl: data["author"]["imageUrl"] as String?,
      ),
      id: data["id"] as String,
      createdAt: data["createdAt"] as int?,
      text: data["text"] as String,
      status: _getStatus(data["status"] as String?),
    );
  }

  /// gets the Status type from string
  static types.Status? _getStatus(String? status) {
    if (status == null) return null;

    const statusMap = {
      "delivered": types.Status.delivered,
      "error": types.Status.error,
      "seen": types.Status.seen,
      "sending": types.Status.sending,
      "sent": types.Status.sent,
    };

    return statusMap[status];
  }

  /// When user visits the GlobalChat page
  /// user is set as online in the database
  static void _setPlayerOnline(types.User user) {
    if (_playersOnlineRef == null) return;
    _playerRef = _playersOnlineRef!.child(user.id);
    _playerRef!.set(user.toJson());
    // register disconnect handler
    _registerDisconnect();
  }

  /// disconnects the user and sets _playerRef to null
  static void _registerDisconnect() async {
    if (_playerRef == null) return;
    await _playerRef!.onDisconnect().remove();
  }

  /// Keeps the chat synced offline
  static void _keepChatMessagesSynced() {
    if (_messagesRef == null) return;
    if (constants.isWeb) return;

    _messagesRef!.keepSynced(true);
  }
}
