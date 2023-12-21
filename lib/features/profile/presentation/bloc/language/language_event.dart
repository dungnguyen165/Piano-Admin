import '../../../profile.dart';

abstract class LanguageEvent {
  const LanguageEvent();
}

class LanguageStarted extends LanguageEvent {
  LanguageStarted();
}

class LanguageChanged extends LanguageEvent {
  LanguageChanged({required this.language});

  final LanguageEntity language;
}
