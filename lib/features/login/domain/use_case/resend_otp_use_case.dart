import 'package:piano_admin/core/core.dart';

class ResendOtpUseCase extends UseCase<Future<void>, String> {
  ResendOtpUseCase({required UserRepository repository})
      : _repository = repository;

  final UserRepository _repository;

  @override
  Future<void> call({String? params}) {
    return _repository.resendOtp(phoneNumber: params!);
  }
}
