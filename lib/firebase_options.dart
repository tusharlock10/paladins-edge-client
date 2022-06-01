// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDbLp9cDpEOuQ-yZwjJ0LfdlRFt7-UP4Ds',
    appId: '1:280154424805:web:39b3e66d9e4677b0aa1b0c',
    messagingSenderId: '280154424805',
    projectId: 'paladins-edge',
    authDomain: 'paladins-edge.firebaseapp.com',
    databaseURL: 'https://paladins-edge-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'paladins-edge.appspot.com',
    measurementId: 'G-LQLMCT8NC9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCUMi5hu_qRESYn89dp0VFjpeXg-l4HEfo',
    appId: '1:280154424805:android:06755c7776c617c0aa1b0c',
    messagingSenderId: '280154424805',
    projectId: 'paladins-edge',
    databaseURL: 'https://paladins-edge-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'paladins-edge.appspot.com',
  );
}
