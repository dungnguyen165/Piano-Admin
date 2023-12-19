import 'package:piano_admin/features/authentication/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Stream<UserEntity> get userStream;
  UserEntity get currentUser;
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
