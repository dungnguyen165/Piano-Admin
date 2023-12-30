import 'package:get_it/get_it.dart';
import 'features/authentication/authentication.dart';
import 'features/profile/profile.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Data source
  sl.registerSingleton<AuthLocalDataSource>(HiveAuthLocalDataSource());
  sl.registerSingleton<AuthRemoteDataSource>(FirebaseAuthRemoteDataSource());
  sl.registerSingleton<ProfileLocalDataSource>(CacheProfileLocalDataSource());

  // Repository
  sl.registerSingleton<AuthRepository>(AuthRepositoryImp(
    localDataSource: sl(),
    remoteDataSource: sl(),
  ));
  sl.registerSingleton<ProfileRepository>(
    ProfileRepositoryImp(localDataSource: sl()),
  );

  // Use cases
  sl.registerSingleton(GetCurrentUserUseCase(repository: sl()));
  sl.registerSingleton(GetUserStreamUseCase(repository: sl()));
  sl.registerSingleton(LoginUseCase(repository: sl()));
  sl.registerSingleton(VerifyOtpUseCase(repository: sl()));
  sl.registerSingleton(ResendOtpUseCase(repository: sl()));
  sl.registerSingleton(LogoutUseCase(repository: sl()));
  sl.registerSingleton(GetLanguageUseCase(repository: sl()));
  sl.registerSingleton(SaveLanguageUseCase(repository: sl()));
  sl.registerSingleton(GetThemeUseCase(repository: sl()));
  sl.registerSingleton(SaveThemeUseCase(repository: sl()));

  // Bloc
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      getUserStreamUseCase: sl(),
      getCurrentUserUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(
      loginUseCase: sl(),
      verifyOtpUseCase: sl(),
      resendOtpUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => LanguageBloc(
      getLanguageUseCase: sl(),
      saveLanguageUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ThemeBloc(
      getThemeUseCase: sl(),
      saveThemeUseCase: sl(),
    ),
  );
}
