import 'package:piano_admin/features/profile/domain/entity/language_entity.dart';

abstract class LanguageLocalDataSource {
  Future<void> saveLanguage(LanguageEntity language);
  LanguageEntity getLanguage();
}
