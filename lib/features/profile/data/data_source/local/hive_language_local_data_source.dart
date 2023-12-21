import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piano_admin/core/core.dart';
import 'package:piano_admin/features/profile/data/data_source/local/language_local_data_source.dart';
import 'package:piano_admin/features/profile/domain/entity/language_entity.dart';

class HiveLanguageLocalDataSource implements LanguageLocalDataSource {
  static const languageCacheKey = '__language_cache_key';

  HiveLanguageLocalDataSource({Cache? cache}) : _cache = cache ?? HiveCache();

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
}
