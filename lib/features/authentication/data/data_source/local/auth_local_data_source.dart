import '../../../authentication.dart';

abstract class AuthLocalDataSource {
  Future<void> saveCurrentUser(UserModel user);

  UserModel getCurrentUser();
}
