import 'package:piano_admin/core/core.dart';
import 'package:piano_admin/features/profile/profile.dart';

class SaveLanguageUseCase implements UseCase<Future<void>, LanguageEntity> {
  SaveLanguageUseCase({required LanguageRepository repository})
      : _repository = repository;

  final LanguageRepository _repository;

  @override
  Future<void> call({LanguageEntity? params}) {
    return _repository.saveLanguage(params!);
  }
}
