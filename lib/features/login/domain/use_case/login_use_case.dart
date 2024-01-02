import 'package:piano_admin/core/core.dart';

class LoginUseCase implements UseCase<Future<void>, String> {
  LoginUseCase({required UserRepository repository}) : _repository = repository;

  final UserRepository _repository;

  @override
  Future<void> call({String? params}) {
    return _repository.login(
      phoneNumber: params!,
    );
  }
}
