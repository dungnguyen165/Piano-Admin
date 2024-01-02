import 'package:firebase_auth/firebase_auth.dart';
import 'core.dart';

extension UserHelper on User {
  /// Maps a [firebase_auth.User] into a [UserModel].
  UserModel get toUserModel {
    return UserModel(
      id: uid,
      email: email,
      name: displayName,
      photo: photoURL,
      phone: phoneNumber,
    );
  }
}
