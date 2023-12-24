import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:piano_admin/core/logger.dart';
import '../../../authentication.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required GetUserStreamUseCase getUserStreamUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required SignUpUseCase signUpUseCase,
    required LogoutUseCase logoutUseCase,
  })  : _getUserStreamUseCase = getUserStreamUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase,
        _logoutUseCase = logoutUseCase,
        super(
          getCurrentUserUseCase().isNotEmpty
              ? AuthState.authenticated(getCurrentUserUseCase())
              : const AuthState.unauthenticated(),
        ) {
    on<AuthUserChanged>(_onUserChanged);
    on<AuthLogoutRequested>(_onLogoutRequested);

    _userSubscription = _getUserStreamUseCase().listen((user) {
      logger.d('user change $user');
      add(AuthUserChanged(user));
    });
  }

  final GetUserStreamUseCase _getUserStreamUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final LogoutUseCase _logoutUseCase;

  late final StreamSubscription<UserEntity> _userSubscription;

  void _onUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(event.user.isNotEmpty
        ? AuthState.authenticated(event.user)
        : const AuthState.unauthenticated());
  }

  void _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) {
    unawaited(_logoutUseCase());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
