import 'package:piano_admin/core/core.dart';

class UpdateUserNameUseCase implements UseCase<Future<void>, String> {
  UpdateUserNameUseCase({required UserRepository repository})
      : _repository = repository;

  final UserRepository _repository;

  @override
  Future<void> call({String? params}) {
    return _repository.updateUserAvatar(params!);
  }
}
