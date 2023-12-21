import 'package:piano_admin/features/profile/profile.dart';

abstract class ThemeEvent {
  ThemeEvent();
}

class ThemeStarted extends ThemeEvent {
  ThemeStarted();
}

class ThemeChanged extends ThemeEvent {
  ThemeChanged({required this.theme});

  final ThemeEntity theme;
}
