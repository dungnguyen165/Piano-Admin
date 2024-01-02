import '../../../core.dart';

class UserRepositoryImp extends UserRepository {
  UserRepositoryImp({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final UserLocalDataSource localDataSource;
  final UserRemoteDataSource remoteDataSource;

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

  @override
  Future<void> updateUsername(String username) {
    // TODO: implement updateUsername
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserAvatar(String photoUrl) {
    // TODO: implement updateUserAvatar
    throw UnimplementedError();
  }

  @override
  Future<String> uploadAvatar(String uri) {
    // TODO: implement uploadAvatar
    throw UnimplementedError();
  }
}
