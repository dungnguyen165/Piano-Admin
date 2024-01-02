import '../../authentication.dart';

abstract class AuthRepository {
  Stream<UserEntity> get userStream;

  UserEntity get currentUser;

  Future<void> login({required String phoneNumber});

  Future<void> verifyOtp({required String otp});

  Future<void> resendOtp({required String phoneNumber});

  Future<void> logout();
}
