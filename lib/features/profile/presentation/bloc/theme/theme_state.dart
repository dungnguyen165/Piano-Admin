import 'package:equatable/equatable.dart';
import '../../../profile.dart';

abstract class ThemeState extends Equatable {
  const ThemeState({required this.theme});

  final ThemeEntity theme;

  @override
  List<Object?> get props => [theme];
}

class ThemeLoadedSuccess extends ThemeState {
  const ThemeLoadedSuccess(ThemeEntity theme) : super(theme: theme);
}
