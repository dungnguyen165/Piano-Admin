import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:piano_admin/features/authentication/domain/entity/email_entity.dart';
import 'package:piano_admin/features/authentication/domain/entity/password_entity.dart';
import 'package:piano_admin/features/authentication/presentation/bloc/login/login_state.dart';

import '../../../authentication.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required LoginUseCase loginUseCase,
    required LoginWithGoogleUseCase loginWithGoogleUseCase,
  })  : _loginUseCase = loginUseCase,
        _loginWithGoogleUseCase = loginWithGoogleUseCase,
        super(const LoginState());

  final LoginUseCase _loginUseCase;
  final LoginWithGoogleUseCase _loginWithGoogleUseCase;

  void emailChanged(String value) {
    final email = EmailEntity.dirty(value);
    emit(state.copyWith(
      email: email,
      isValid: Formz.validate([email, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = PasswordEntity.dirty(value);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([state.email, password]),
    ));
  }

  Future<void> loginWithCredential() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _loginUseCase(
        params: LoginUseCaseParams(
          email: state.email.value,
          password: state.password.value,
        ),
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        status: FormzSubmissionStatus.failure,
      ));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _loginWithGoogleUseCase();
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LoginWithGoogleFailure catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        status: FormzSubmissionStatus.failure,
      ));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
