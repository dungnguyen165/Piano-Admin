import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'core/core.dart';
import 'features/features.dart';
import 'features/profile/profile.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Data source
  sl.registerSingleton<UserLocalDataSource>(CacheUserLocalDataSource());
  sl.registerSingleton<UserRemoteDataSource>(FirebaseUserRemoteDataSource(
    firebaseAuth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ));
  sl.registerSingleton<FirebaseUserRemoteDataSource>(
      FirebaseUserRemoteDataSource(
    firebaseAuth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
    firebaseStorage: FirebaseStorage.instance,
  ));
  sl.registerSingleton<SettingLocalDataSource>(CacheSettingLocalDataSource());

  // Repository
  sl.registerSingleton<UserRepository>(UserRepositoryImp(
    localDataSource: sl(),
    remoteDataSource: sl(),
  ));
  sl.registerSingleton<SettingRepository>(
    SettingRepositoryImp(localDataSource: sl()),
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
  sl.registerFactory<UserBloc>(
    () => UserBloc(
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
  sl.registerFactory<LanguageBloc>(
    () => LanguageBloc(
      getLanguageUseCase: sl(),
      saveLanguageUseCase: sl(),
    ),
  );
  sl.registerFactory<ThemeBloc>(
    () => ThemeBloc(
      getThemeUseCase: sl(),
      saveThemeUseCase: sl(),
    ),
  );
  sl.registerFactory<HomeCubit>(() => HomeCubit());
}
