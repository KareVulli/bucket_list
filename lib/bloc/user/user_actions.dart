abstract class UserAction {
  const UserAction();
}

class AppStarted extends UserAction {}

class LogInWithGoogle extends UserAction {}

class LogOut extends UserAction {}