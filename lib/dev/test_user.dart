import 'package:paladinsedge/constants.dart' as constants;

class TestUser {
  final String name;
  final String email;
  final String uid;

  const TestUser({
    this.name = "Test User",
    this.email = "test@paladinsedge.app",
    this.uid = "62763576287735635",
  });
}

const testUser = constants.isDebug ? TestUser() : null;
