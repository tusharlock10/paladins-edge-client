import "package:firebase_core/firebase_core.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/firebase_options.dart" as firebase_options;

Future<void> initFirebaseApp() {
  return Firebase.initializeApp(
    name: constants.isMobile ? "root" : null,
    options: firebase_options.DefaultFirebaseOptions.currentPlatform,
  );
}
