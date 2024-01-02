import '../../local/model/user_model.dart';

abstract class UserRemoteDataSource {
  Stream<UserModel> get userStream;

  Future<void> login({required String phoneNumber});

  Future<void> verifyOtp({required String otp});

  Future<void> resendOtp({required String phoneNumber});

  Future<void> logout();

  Future<void> updateUsername(String username);

  // Return downloadable url
  Future<String> uploadAvatar(String uri);

  Future<void> updateUserAvatar(String photoUrl);
}
