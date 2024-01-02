import 'package:piano_admin/core/use_case/use_case.dart';

import '../../authentication.dart';

class LoginUseCase implements UseCase<Future<void>, String> {
  LoginUseCase({required AuthRepository repository}) : _repository = repository;

  final AuthRepository _repository;

  @override
  Future<void> call({String? params}) {
    return _repository.login(
      phoneNumber: params!,
    );
  }
}
