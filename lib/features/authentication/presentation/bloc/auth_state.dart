import 'package:equatable/equatable.dart';
import '../../authentication.dart';

enum AuthStatus { authenticated, unauthenticated }

final class AuthState extends Equatable {
  const AuthState._({
    required this.status,
    this.user = UserEntity.empty,
  });

  const AuthState.authenticated(UserEntity user)
      : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  final AuthStatus status;
  final UserEntity user;

  @override
  List<Object?> get props => [status, user];
}
