import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../profile.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc({
    required GetLanguageUseCase getLanguageUseCase,
    required SaveLanguageUseCase saveLanguageUseCase,
  })  : _getLanguageUseCase = getLanguageUseCase,
        _saveLanguageUseCase = saveLanguageUseCase,
        super(const LanguageLoadSuccess(LanguageEntity.english())) {
    on<LanguageStarted>(_onLanguageStarted);
    on<LanguageChanged>(_onLanguageChanged);
  }

  final GetLanguageUseCase _getLanguageUseCase;
  final SaveLanguageUseCase _saveLanguageUseCase;

  void _onLanguageStarted(LanguageStarted event, Emitter emit) {
    final language = _getLanguageUseCase();
    emit(LanguageLoadSuccess(language));
  }

  void _onLanguageChanged(LanguageChanged event, Emitter emit) async {
    await _saveLanguageUseCase(params: event.language);
    emit(LanguageLoadSuccess(event.language));
  }
}
