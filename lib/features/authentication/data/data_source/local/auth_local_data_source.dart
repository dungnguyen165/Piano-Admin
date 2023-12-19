import 'package:piano_admin/features/authentication/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  void saveCurrentUser(UserModel user);
  UserModel getCurrentUser();
}