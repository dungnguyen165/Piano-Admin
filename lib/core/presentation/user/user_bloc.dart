import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../core.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    required GetUserStreamUseCase getUserStreamUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required LogoutUseCase logoutUseCase,
  })  : _getUserStreamUseCase = getUserStreamUseCase,
        _logoutUseCase = logoutUseCase,
        super(
          getCurrentUserUseCase().isNotEmpty
              ? UserState.authenticated(getCurrentUserUseCase())
              : const UserState.unauthenticated(),
        ) {
    on<UserChanged>(_onUserChanged);
    on<UserLogoutRequested>(_onLogoutRequested);

    _userSubscription = _getUserStreamUseCase().listen((user) {
      logger.d('user change $user');
      add(UserChanged(user));
    });
  }

  final GetUserStreamUseCase _getUserStreamUseCase;
  final LogoutUseCase _logoutUseCase;

  late final StreamSubscription<UserEntity> _userSubscription;

  void _onUserChanged(
    UserChanged event,
    Emitter<UserState> emit,
  ) {
    emit(event.user.isNotEmpty
        ? UserState.authenticated(event.user)
        : const UserState.unauthenticated());
  }

  void _onLogoutRequested(
    UserLogoutRequested event,
    Emitter<UserState> emit,
  ) {
    unawaited(_logoutUseCase());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
