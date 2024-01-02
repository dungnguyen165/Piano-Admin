import 'package:piano_admin/core/core.dart';

class VerifyOtpUseCase extends UseCase<Future<void>, String> {
  VerifyOtpUseCase({required UserRepository repository})
      : _repository = repository;

  final UserRepository _repository;

  @override
  Future<void> call({String? params}) {
    return _repository.verifyOtp(otp: params!);
  }
}
