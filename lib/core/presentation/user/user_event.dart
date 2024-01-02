import '../../core.dart';

sealed class UserEvent {
  const UserEvent();
}

final class UserLogoutRequested extends UserEvent {
  const UserLogoutRequested();
}

final class UserChanged extends UserEvent {
  const UserChanged(this.user);

  final UserEntity user;
}
