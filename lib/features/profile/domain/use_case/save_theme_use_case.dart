import 'package:piano_admin/core/core.dart';
import '../../profile.dart';

class SaveThemeUseCase implements UseCase<Future<void>, ThemeEntity> {
  SaveThemeUseCase({required ProfileRepository repository})
      : _repository = repository;

  final ProfileRepository _repository;

  @override
  Future<void> call({ThemeEntity? params}) {
    return _repository.saveTheme(params!);
  }
}
