import 'package:piano_admin/core/core.dart';
import '../../profile.dart';

class GetThemeUseCase implements UseCase<ThemeEntity, void> {
  GetThemeUseCase({required SettingRepository repository})
      : _repository = repository;

  final SettingRepository _repository;

  @override
  ThemeEntity call({void params}) {
    return _repository.getTheme();
  }
}
