import 'package:piano_admin/core/core.dart';

class UpdateAvatarUseCase implements UseCase<Future<void>, String> {
  UpdateAvatarUseCase({required UserRepository repository})
      : _repository = repository;

  final UserRepository _repository;

  @override
  Future<void> call({String? params}) async {
    final String avatarUrl = await _repository.uploadAvatar(params!);
    return _repository.updateUserAvatar(avatarUrl);
  }
}
