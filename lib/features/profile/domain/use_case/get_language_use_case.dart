import 'package:piano_admin/core/core.dart';
import 'package:piano_admin/features/profile/profile.dart';

class GetLanguageUseCase implements UseCase<LanguageEntity, void> {
  GetLanguageUseCase({required LanguageRepository repository})
      : _repository = repository;

  final LanguageRepository _repository;

  @override
  LanguageEntity call({void params}) {
    return _repository.getLanguage();
  }
}
