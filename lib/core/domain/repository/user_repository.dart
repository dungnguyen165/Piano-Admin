import '../entity/user_entity.dart';

abstract class UserRepository {
  Stream<UserEntity> get userStream;

  UserEntity get currentUser;

  Future<void> login({required String phoneNumber});

  Future<void> verifyOtp({required String otp});

  Future<void> resendOtp({required String phoneNumber});

  Future<void> logout();

  Future<void> updateUsername(String username);

  // Return downloadable url
  Future<String> uploadAvatar(String uri);

  Future<void> updateUserAvatar(String photoUrl);
}
