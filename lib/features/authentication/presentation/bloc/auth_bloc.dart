import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../authentication.dart';

class AuthBloc
    extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required GetUserStreamUseCase getUserStreamUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required SignUpUseCase signUpUseCase,
    required LoginUseCase loginUseCase,
    required LoginWithGoogleUseCase loginWithGoogleUseCase,
    required LogoutUseCase logoutUseCase,
  })  : _getUserStreamUseCase = getUserStreamUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase,
        _signUpUseCase = signUpUseCase,
        _loginUseCase = loginUseCase,
        _loginWithGoogleUseCase = loginWithGoogleUseCase,
        _logoutUseCase = logoutUseCase,
        super(
          getCurrentUserUseCase().isNotEmpty
              ? AuthState.authenticated(getCurrentUserUseCase())
              : const AuthState.unauthenticated(),
        ) {
    on<AuthUserChanged>(_onUserChanged);
    on<AuthLogoutRequested>(_onLogoutRequested);

    _userSubscription = getUserStreamUseCase().listen((user) {
      add(AuthUserChanged(user));
    });
  }

  final GetUserStreamUseCase _getUserStreamUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final SignUpUseCase _signUpUseCase;
  final LoginUseCase _loginUseCase;
  final LoginWithGoogleUseCase _loginWithGoogleUseCase;
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
