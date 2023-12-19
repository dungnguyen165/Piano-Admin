import 'package:piano_admin/features/authentication/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Stream<UserModel> get userStream;
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  });
  Future<void> login({required String email, required String password});
  Future<void> loginWithGoogle();
  Future<void> logout();

}
