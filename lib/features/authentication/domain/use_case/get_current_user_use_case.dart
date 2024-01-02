import 'package:piano_admin/core/use_case/use_case.dart';
import '../../authentication.dart';

class GetCurrentUserUseCase implements UseCase<UserEntity, void> {
  GetCurrentUserUseCase({required AuthRepository repository})
      : _repository = repository;

  final AuthRepository _repository;

  @override
  UserEntity call({void params}) {
    return _repository.currentUser;
  }
}
