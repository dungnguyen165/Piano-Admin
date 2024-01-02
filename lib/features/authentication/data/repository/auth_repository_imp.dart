import '../../authentication.dart';

class AuthRepositoryImp extends AuthRepository {
  AuthRepositoryImp({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;

  @override
  Stream<UserEntity> get userStream {
    return remoteDataSource.userStream.map((userModel) {
      localDataSource.saveCurrentUser(userModel);
      return userModel.toEntity();
    });
  }

  @override
  UserEntity get currentUser {
    return localDataSource.getCurrentUser().toEntity();
  }

  @override
  Future<void> login({required String phoneNumber}) =>
      remoteDataSource.login(phoneNumber: phoneNumber);

  @override
  Future<void> verifyOtp({required String otp}) =>
      remoteDataSource.verifyOtp(otp: otp);

  @override
  Future<void> resendOtp({required String phoneNumber}) =>
      remoteDataSource.resendOtp(phoneNumber: phoneNumber);

  @override
  Future<void> logout() => remoteDataSource.logout();
}
