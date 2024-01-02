import 'package:piano_admin/core/core.dart';
import '../../profile.dart';

class GetLanguageUseCase implements UseCase<LanguageEntity, void> {
  GetLanguageUseCase({required SettingRepository repository})
      : _repository = repository;

  final SettingRepository _repository;

  @override
  LanguageEntity call({void params}) {
    return _repository.getLanguage();
  }
}
