import "package:paladinsedge/constants/index.dart" as constants;
import "package:window_manager/window_manager.dart";

Future<void> initializeDesktop() async {
  if (!constants.isDesktop) return;

  await windowManager.ensureInitialized();
  windowManager.setTitle("Paladins Edge");
}
