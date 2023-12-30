import 'package:firebase_auth/firebase_auth.dart';
import 'package:piano_admin/core/core.dart';
import 'package:piano_admin/features/authentication/data/data_source/remote/auth_remote_data_source.dart';
import 'package:piano_admin/features/authentication/data/models/user_model.dart';

import '../../models/exception.dart';

class FirebaseAuthRemoteDataSource implements AuthRemoteDataSource {
  FirebaseAuthRemoteDataSource({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  String? _phoneNumber;
  String? _verificationId;
  int? _resendToken;

  @override
  Stream<UserModel> get userStream {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user =
          firebaseUser == null ? UserModel.empty : firebaseUser.toUserModel;
      return user;
    });
  }

  @override
  Future<void> login({required String phoneNumber}) async {
    try {
      _phoneNumber = phoneNumber;
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          logger.d('verificationCompleted, credential: $credential');
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          logger.d('verificationFailed, exeception: $e');
          throw e;
        },
        codeSent: (String verificationId, int? resendToken) {
          logger.d(
              'codeSent, verificationId: $verificationId, resendToken: $resendToken');
          _verificationId = verificationId;
          _resendToken = resendToken;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          logger.d('codeAutoRetrievalTimeout, verificationId: $verificationId');
          _verificationId = verificationId;
          _verificationId = verificationId;
        },
      );
    } on FirebaseAuthException catch (e) {
      throw LogInWithPhoneNumberFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithPhoneNumberFailure();
    }
  }

  @override
  Future<void> verifyOtp({required String otp}) async {
    logger.d('verifyOtp, otp: $otp');
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: otp);
      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw LogInWithPhoneNumberFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithPhoneNumberFailure();
    }
  }

  @override
  Future<void> resendOtp({required String phoneNumber}) async {
    logger.d('resendOtp, phoneNumber $phoneNumber');
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: _phoneNumber,
        forceResendingToken: _resendToken,
        verificationCompleted: (PhoneAuthCredential credential) async {
          logger.d('verificationCompleted, credential: $credential');
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          logger.d('verificationFailed, exeception: $e');
          throw e;
        },
        codeSent: (String verificationId, int? resendToken) {
          logger.d(
              'codeSent, verificationId: $verificationId, resendToken: $resendToken');
          _verificationId = verificationId;
          _resendToken = resendToken;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          logger.d('codeAutoRetrievalTimeout, verificationId: $verificationId');
          _verificationId = verificationId;
          _verificationId = verificationId;
        },
      );
    } on FirebaseAuthException catch (e) {
      throw LogInWithPhoneNumberFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithPhoneNumberFailure();
    }
  }

  @override
  Future<void> logout() async {
    logger.d('logout');
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
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
