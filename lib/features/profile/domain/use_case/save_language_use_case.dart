import 'package:piano_admin/core/core.dart';
import '../../profile.dart';

class SaveLanguageUseCase implements UseCase<Future<void>, LanguageEntity> {
  SaveLanguageUseCase({required ProfileRepository repository})
      : _repository = repository;

  final ProfileRepository _repository;

  @override
  Future<void> call({LanguageEntity? params}) {
    return _repository.saveLanguage(params!);
  }
}
