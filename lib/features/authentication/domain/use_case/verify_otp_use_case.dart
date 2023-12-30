import 'package:piano_admin/core/core.dart';
import '../../authentication.dart';

class VerifyOtpUseCase extends UseCase<Future<void>, String> {
  VerifyOtpUseCase({required AuthRepository repository})
      : _repository = repository;

  final AuthRepository _repository;

  @override
  Future<void> call({String? params}) {
    return _repository.verifyOtp(otp: params!);
  }
}
