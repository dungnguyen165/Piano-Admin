import '../../profile.dart';

abstract class ProfileRepository {
  Future<void> saveLanguage(LanguageEntity language);
  LanguageEntity getLanguage();
  Future<void> saveTheme(ThemeEntity theme);
  ThemeEntity getTheme();
}
