import '../../../core.dart';

class LogoutUseCase implements UseCase<Future<void>, void> {
  LogoutUseCase({required UserRepository repository})
      : _repository = repository;

  final UserRepository _repository;

  @override
  Future<void> call({void params}) {
    return _repository.logout();
  }
}
