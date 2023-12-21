import 'package:piano_admin/core/core.dart';
import '../../profile.dart';

class GetThemeUseCase implements UseCase<ThemeEntity, void> {
  GetThemeUseCase({required ProfileRepository repository})
      : _repository = repository;

  final ProfileRepository _repository;

  @override
  ThemeEntity call({void params}) {
    return _repository.getTheme();
  }
}
