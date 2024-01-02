import '../../../authentication.dart';

abstract class AuthRemoteDataSource {
  Stream<UserModel> get userStream;

  Future<void> login({required String phoneNumber});

  Future<void> verifyOtp({required String otp});

  Future<void> resendOtp({required String phoneNumber});

  Future<void> logout();
}
