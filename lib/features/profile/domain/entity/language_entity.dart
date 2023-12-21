import 'dart:ui';

final class LanguageEntity {
  const LanguageEntity._({
    required this.code,
    required this.value,
    required this.nativeValue,
  });

  final String code;
  final String value;
  final String nativeValue;

  const LanguageEntity.english()
      : this._(code: 'en', value: 'English', nativeValue: 'English');
  const LanguageEntity.vietnamese()
      : this._(code: 'vi', value: 'Vietnamese', nativeValue: 'Tiếng Việt');

  static const languages = [
    LanguageEntity.english(),
    LanguageEntity.vietnamese(),
  ];

  Locale get locale {
    return Locale(code);
  }
}
