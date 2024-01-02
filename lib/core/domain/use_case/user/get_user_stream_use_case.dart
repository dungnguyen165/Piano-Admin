import '../../../core.dart';

class GetUserStreamUseCase implements UseCase<Stream<UserEntity>, void> {
  GetUserStreamUseCase({required UserRepository repository})
      : _repository = repository;

  final UserRepository _repository;

  @override
  Stream<UserEntity> call({void params}) {
    return _repository.userStream;
  }
}
