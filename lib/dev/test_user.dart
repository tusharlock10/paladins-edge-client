import "package:paladinsedge/constants/index.dart" as constants;

class TestUser {
  final String name;
  final String email;
  final String uid;

  const TestUser({
    this.name = "Test2 User",
    this.email = "test2@paladinsedge.app",
    this.uid = "62763576287735636",
  });
}

const testUser = constants.isDebug ? TestUser() : null;
