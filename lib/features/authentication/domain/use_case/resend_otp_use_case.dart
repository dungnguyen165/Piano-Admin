import 'package:piano_admin/core/core.dart';
import '../../authentication.dart';

class ResendOtpUseCase extends UseCase<Future<void>, String> {
  ResendOtpUseCase({required AuthRepository repository})
      : _repository = repository;

  final AuthRepository _repository;

  @override
  Future<void> call({String? params}) {
    return _repository.resendOtp(phoneNumber: params!);
  }
}
