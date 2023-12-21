import 'package:flutter/material.dart';

class ThemeEntity {
  static ThemeEntity get(String value) {
    switch (value) {
      case 'light':
        return const ThemeEntity.light();
      case 'dark':
        return const ThemeEntity.dark();
    }
    return const ThemeEntity.system();
  }

  static const themes = [
    ThemeEntity.light(),
    ThemeEntity.dark(),
    ThemeEntity.system()
  ];

  const ThemeEntity._({required this.value, required this.mode});

  const ThemeEntity.light() : this._(value: 'light', mode: ThemeMode.light);
  const ThemeEntity.dark() : this._(value: 'dark', mode: ThemeMode.dark);
  const ThemeEntity.system() : this._(value: 'system', mode: ThemeMode.system);

  final String value;
  final ThemeMode mode;
}
