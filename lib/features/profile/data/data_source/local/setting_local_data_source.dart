import '../../../profile.dart';

abstract class SettingLocalDataSource {
  Future<void> saveLanguage(LanguageEntity language);

  LanguageEntity getLanguage();

  Future<void> saveTheme(ThemeEntity theme);

  ThemeEntity getTheme();
}
