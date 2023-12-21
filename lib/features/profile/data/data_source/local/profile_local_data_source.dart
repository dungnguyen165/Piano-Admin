import '../../../profile.dart';

abstract class ProfileLocalDataSource {
  Future<void> saveLanguage(LanguageEntity language);
  LanguageEntity getLanguage();
  Future<void> saveTheme(ThemeEntity theme);
  ThemeEntity getTheme();
}
