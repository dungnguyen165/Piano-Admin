import 'package:get_it/get_it.dart';
import 'features/authentication/authentication.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Data source
  sl.registerSingleton<AuthLocalDataSource>(HiveAuthLocalDataSource());
  sl.registerSingleton<AuthRemoteDataSource>(FirebaseAuthRemoteDataSource());

  // Repository
  sl.registerSingleton<AuthRepository>(AuthRepositoryImp(
    localDataSource: sl(),
    remoteDataSource: sl(),
  ));

  // Use cases
  sl.registerSingleton(GetCurrentUserUseCase(repository: sl()));
  sl.registerSingleton(GetUserStreamUseCase(repository: sl()));
  sl.registerSingleton(LoginUseCase(repository: sl()));
  sl.registerSingleton(LoginWithGoogleUseCase(repository: sl()));
  sl.registerSingleton(SignUpUseCase(repository: sl()));
  sl.registerSingleton(LogoutUseCase(repository: sl()));

  // Bloc
  sl.registerFactory<AuthBloc>(() => AuthBloc(
        getUserStreamUseCase: sl(),
        getCurrentUserUseCase: sl(),
        signUpUseCase: sl(),
        loginUseCase: sl(),
        loginWithGoogleUseCase: sl(),
        logoutUseCase: sl(),
      ));
}
