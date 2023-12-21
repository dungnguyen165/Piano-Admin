import '../../profile.dart';

class ProfileRepositoryImp implements ProfileRepository {
  ProfileRepositoryImp({required ProfileLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  final ProfileLocalDataSource _localDataSource;

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
