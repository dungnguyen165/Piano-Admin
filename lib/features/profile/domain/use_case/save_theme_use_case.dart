import 'package:piano_admin/core/core.dart';
import '../../profile.dart';

class SaveThemeUseCase implements UseCase<Future<void>, ThemeEntity> {
  SaveThemeUseCase({required SettingRepository repository})
      : _repository = repository;

  final SettingRepository _repository;

  @override
  Future<void> call({ThemeEntity? params}) {
    return _repository.saveTheme(params!);
  }
}
