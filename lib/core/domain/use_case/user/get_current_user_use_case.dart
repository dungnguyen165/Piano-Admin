import '../../../core.dart';

class GetCurrentUserUseCase implements UseCase<UserEntity, void> {
  GetCurrentUserUseCase({required UserRepository repository})
      : _repository = repository;

  final UserRepository _repository;

  @override
  UserEntity call({void params}) {
    return _repository.currentUser;
  }
}
