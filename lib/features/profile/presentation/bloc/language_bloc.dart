import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piano_admin/features/profile/domain/entity/language_entity.dart';
import 'package:piano_admin/features/profile/domain/use_case/get_language_use_case.dart';
import 'package:piano_admin/features/profile/domain/use_case/save_language_use_case.dart';
import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc({
    required GetLanguageUseCase getLanguageUseCase,
    required SaveLanguageUseCase saveLanguageUseCase,
  })  : _getLanguageUseCase = getLanguageUseCase,
        _saveLanguageUseCase = saveLanguageUseCase,
        super(LanguageLoadSuccess(const LanguageEntity.english())) {
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
