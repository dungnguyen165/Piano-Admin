import 'package:piano_admin/core/core.dart';
import '../../profile.dart';

class SaveLanguageUseCase implements UseCase<Future<void>, LanguageEntity> {
  SaveLanguageUseCase({required SettingRepository repository})
      : _repository = repository;

  final SettingRepository _repository;

  @override
  Future<void> call({LanguageEntity? params}) {
    return _repository.saveLanguage(params!);
  }
}
