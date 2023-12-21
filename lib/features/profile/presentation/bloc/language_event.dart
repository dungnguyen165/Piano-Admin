import 'package:piano_admin/features/profile/domain/entity/language_entity.dart';

abstract class LanguageEvent {
  const LanguageEvent();
}

class LanguageStarted extends LanguageEvent {
  LanguageStarted();
}

class LanguageChanged extends LanguageEvent {
  LanguageChanged(this.language);

  final LanguageEntity language;
}
