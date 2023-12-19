import 'package:bloc/bloc.dart';

import 'package:piano_admin/core/logger.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    logger.i('BLOC CHANGE: ${bloc.runtimeType} - $change');
    super.onChange(bloc, change);
  }

  @override
  void onCreate(BlocBase bloc) {
    logger.i('BLOC CREATE: ${bloc.runtimeType}');
    super.onCreate(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.e('BLOC ERROR: ${bloc.runtimeType} - $error - $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    logger.i('BLOC EVENT: ${bloc.runtimeType} - $event');
    super.onEvent(bloc, event);
  }

  @override
  void onClose(BlocBase bloc) {
    logger.i('BLOC CLOSE: ${bloc.runtimeType}');
    super.onClose(bloc);
  }
}
