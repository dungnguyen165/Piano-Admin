import 'package:piano_admin/core/core.dart';
import '../../../profile.dart';

class CacheProfileLocalDataSource implements ProfileLocalDataSource {
  static const languageCacheKey = '__language_cache_key';
  static const themeCacheKey = '__theme_cache_key';

  CacheProfileLocalDataSource({Cache? cache}) : _cache = cache ?? HiveCache();

  final Cache _cache;

  @override
  LanguageEntity getLanguage() {
    final code = _cache.read<String>(key: languageCacheKey) ??
        const LanguageEntity.english().code;
    final language = LanguageEntity.languages.firstWhere(
      (language) => language.code == code,
      orElse: LanguageEntity.english,
    );
    return language;
  }

  @override
  Future<void> saveLanguage(LanguageEntity language) {
    return _cache.write(key: languageCacheKey, value: language.code);
  }

  @override
  ThemeEntity getTheme() {
    final value = _cache.read<String>(key: themeCacheKey);
    if (value == null) return const ThemeEntity.system();
    return ThemeEntity.get(value);
  }

  @override
  Future<void> saveTheme(ThemeEntity theme) {
    return _cache.write(key: themeCacheKey, value: theme.value);
  }
}
