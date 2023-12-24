import 'package:piano_admin/core/use_case/use_case.dart';
import 'package:piano_admin/features/authentication/domain/repository/auth_repository.dart';

class LoginUseCase implements UseCase<Future<void>, LoginUseCaseParams> {
  LoginUseCase({required AuthRepository repository}) : _repository = repository;

  final AuthRepository _repository;

  @override
  Future<void> call({LoginUseCaseParams? params}) {
    return _repository.login(
      email: params!.email,
      password: params.password,
    );
  }
}

class LoginUseCaseParams {
  LoginUseCaseParams({required this.email, required this.password});

  final String email;
  final String password;
}
