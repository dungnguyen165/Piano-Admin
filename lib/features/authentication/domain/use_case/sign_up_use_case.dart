import 'package:piano_admin/core/use_case/use_case.dart';
import 'package:piano_admin/features/authentication/domain/repository/auth_repository.dart';

class SignUpUseCase implements UseCase<Future<void>, SignUpUseCaseParams> {
  SignUpUseCase({required AuthRepository repository})
      : _repository = repository;

  final AuthRepository _repository;

  @override
  Future<void> call({SignUpUseCaseParams? params}) {
    return _repository.signUp(
      email: params!.email,
      password: params.password,
      name: params.name,
      phoneNumber: params.phoneNumber,
    );
  }
}

class SignUpUseCaseParams {
  SignUpUseCaseParams(this.email, this.password, this.name, this.phoneNumber);

  final String email;
  final String password;
  final String name;
  final String phoneNumber;
}
