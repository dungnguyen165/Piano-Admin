import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../profile.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({
    required GetThemeUseCase getThemeUseCase,
    required SaveThemeUseCase saveThemeUseCase,
  })  : _getThemeUseCase = getThemeUseCase,
        _saveThemeUseCase = saveThemeUseCase,
        super(const ThemeLoadedSuccess(ThemeEntity.system())) {
    on<ThemeStarted>(_onThemeStarted);
    on<ThemeChanged>(_onThemeChanged);
  }

  final GetThemeUseCase _getThemeUseCase;
  final SaveThemeUseCase _saveThemeUseCase;

  void _onThemeStarted(ThemeStarted state, Emitter emit) {
    final theme = _getThemeUseCase();
    emit(ThemeLoadedSuccess(theme));
  }

  void _onThemeChanged(ThemeChanged state, Emitter emit) async {
    await _saveThemeUseCase(params: state.theme);
    emit(ThemeLoadedSuccess(state.theme));
  }
}
