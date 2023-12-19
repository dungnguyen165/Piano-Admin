import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:piano_admin/features/authentication/data/data_source/remote/auth_remote_data_source.dart';
import 'package:piano_admin/features/authentication/data/models/user_model.dart';

import '../../models/exception.dart';

class FirebaseAuthRemoteDataSource implements AuthRemoteDataSource {
  FirebaseAuthRemoteDataSource({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  @override
  Stream<UserModel> get userStream {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? UserModel.empty : firebaseUser.toUserModel;
      return user;
    });
  }

  @override
  Future<void> signUp(
      {required String email,
        required String password,
        required String name,
        required String phoneNumber}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //TODO: add user data to FireStore
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw LoginWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> loginWithGoogle() async {
    try {
      late final AuthCredential credential;

      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw LoginWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LoginWithGoogleFailure();
    }
  }

  @override
  Future<void> logout() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

extension on User {
  /// Maps a [firebase_auth.User] into a [UserModel].
  UserModel get toUserModel {
    return UserModel(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
