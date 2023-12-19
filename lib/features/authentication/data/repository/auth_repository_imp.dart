import 'package:piano_admin/features/authentication/data/data_source/local/auth_local_data_source.dart';
import 'package:piano_admin/features/authentication/data/data_source/remote/auth_remote_data_source.dart';
import 'package:piano_admin/features/authentication/domain/entity/user_entity.dart';
import 'package:piano_admin/features/authentication/domain/repository/auth_repository.dart';

class AuthRepositoryImp extends AuthRepository {
  AuthRepositoryImp({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;

  @override
  Stream<UserEntity> get userStream {
    return remoteDataSource.userStream.map((userModel) {
      localDataSource.saveCurrentUser(userModel);
      return userModel.toEntity();
    });
  }

  @override
  UserEntity get currentUser {
    return localDataSource.getCurrentUser().toEntity();
  }

  @override
  Future<void> loginWithGoogle() => remoteDataSource.loginWithGoogle();

  @override
  Future<void> login({required String email, required String password}) =>
      remoteDataSource.login(email: email, password: password);

  @override
  Future<void> signUp(
          {required String email,
          required String password,
          required String name,
          required String phoneNumber}) =>
      remoteDataSource.signUp(
        email: email,
        password: password,
        name: name,
        phoneNumber: phoneNumber,
      );

  @override
  Future<void> logout() => remoteDataSource.logout();
}
