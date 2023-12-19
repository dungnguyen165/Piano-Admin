import 'package:piano_admin/core/use_case/use_case.dart';
import 'package:piano_admin/features/authentication/domain/repository/auth_repository.dart';

class LoginWithGoogleUseCase implements UseCase<Future<void>, void> {
  LoginWithGoogleUseCase({required AuthRepository repository})
      : _repository = repository;

  final AuthRepository _repository;

  @override
  Future<void> call({void params}) {
    return _repository.loginWithGoogle();
  }
}
