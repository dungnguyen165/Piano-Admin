import '../../profile.dart';

class SettingRepositoryImp implements SettingRepository {
  SettingRepositoryImp({
    required SettingLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  final SettingLocalDataSource _localDataSource;

  @override
  LanguageEntity getLanguage() {
    return _localDataSource.getLanguage();
  }

  @override
  Future<void> saveLanguage(LanguageEntity language) {
    return _localDataSource.saveLanguage(language);
  }

  @override
  ThemeEntity getTheme() {
    return _localDataSource.getTheme();
  }

  @override
  Future<void> saveTheme(ThemeEntity theme) {
    return _localDataSource.saveTheme(theme);
  }
}
