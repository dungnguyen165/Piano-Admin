import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import '../../../authentication.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required LoginUseCase loginUseCase,
    required VerifyOtpUseCase verifyOtpUseCase,
    required ResendOtpUseCase resendOtpUseCase,
  })  : _loginUseCase = loginUseCase,
        _verifyOtpUseCase = verifyOtpUseCase,
        _resendOtpUseCase = resendOtpUseCase,
        super(const LoginState());

  final LoginUseCase _loginUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final ResendOtpUseCase _resendOtpUseCase;

  void phoneChanged(String value) {
    final phone = PhoneEntity.dirty(value);
    emit(state.copyWith(
      phone: phone,
      isValid: Formz.validate([phone]),
    ));
  }

  void otpChanged(String value) {
    final otp = OtpEntity.dirty(value);
    emit(state.copyWith(
      otp: otp,
      isValid: Formz.validate([state.phone, otp]),
    ));
  }

  void resetStatus() {
    emit(state.copyWith(
      status: FormzSubmissionStatus.initial,
      isValid: false,
    ));
  }

  Future<void> login() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _loginUseCase(params: state.phone.value);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithPhoneNumberFailure catch (e) {
      emit(state.copyWith(
        error: e,
        status: FormzSubmissionStatus.failure,
      ));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> verifyOtp() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _verifyOtpUseCase(params: state.otp.value);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithPhoneNumberFailure catch (e) {
      emit(state.copyWith(
        error: e,
        status: FormzSubmissionStatus.failure,
      ));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> resendOtp() async {
    if (state.phone.isNotValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _resendOtpUseCase(params: state.phone.value);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithPhoneNumberFailure catch (e) {
      emit(state.copyWith(
        error: e,
        status: FormzSubmissionStatus.failure,
      ));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
