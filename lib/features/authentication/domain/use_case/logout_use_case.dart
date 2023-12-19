import 'package:piano_admin/core/use_case/use_case.dart';
import 'package:piano_admin/features/authentication/domain/repository/auth_repository.dart';

class LogoutUseCase implements UseCase<Future<void>, void> {
  LogoutUseCase({required AuthRepository repository})
      : _repository = repository;

  final AuthRepository _repository;

  @override
  Future<void> call({void params}) {
    return _repository.logout();
  }
}