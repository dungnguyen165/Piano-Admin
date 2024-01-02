import 'package:equatable/equatable.dart';
import '../../core.dart';

enum AuthStatus { authenticated, unauthenticated }

final class UserState extends Equatable {
  const UserState._({
    required this.status,
    this.user = UserEntity.empty,
  });

  const UserState.authenticated(UserEntity user)
      : this._(status: AuthStatus.authenticated, user: user);

  const UserState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  final AuthStatus status;
  final UserEntity user;

  @override
  List<Object?> get props => [status, user];
}
