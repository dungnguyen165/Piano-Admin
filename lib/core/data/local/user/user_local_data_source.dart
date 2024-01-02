import '../model/user_model.dart';

abstract class UserLocalDataSource {
  Future<void> saveCurrentUser(UserModel user);

  UserModel getCurrentUser();
}
