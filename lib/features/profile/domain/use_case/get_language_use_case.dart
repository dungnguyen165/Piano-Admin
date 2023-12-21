import 'package:piano_admin/core/core.dart';
import '../../profile.dart';

class GetLanguageUseCase implements UseCase<LanguageEntity, void> {
  GetLanguageUseCase({required ProfileRepository repository})
      : _repository = repository;

  final ProfileRepository _repository;

  @override
  LanguageEntity call({void params}) {
    return _repository.getLanguage();
  }
}
