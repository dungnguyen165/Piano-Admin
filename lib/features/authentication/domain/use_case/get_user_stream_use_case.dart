import 'package:piano_admin/core/use_case/use_case.dart';
import '../../authentication.dart';

class GetUserStreamUseCase implements UseCase<Stream<UserEntity>, void> {
  GetUserStreamUseCase({required AuthRepository repository})
      : _repository = repository;

  final AuthRepository _repository;

  @override
  Stream<UserEntity> call({void params}) {
    return _repository.userStream;
  }
}
