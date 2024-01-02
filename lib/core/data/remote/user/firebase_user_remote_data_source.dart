import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../core.dart';

class FirebaseUserRemoteDataSource implements UserRemoteDataSource {
  FirebaseUserRemoteDataSource({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
    FirebaseStorage? firebaseStorage,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;

  String? _phoneNumber;
  String? _verificationId;
  int? _resendToken;

  @override
  Stream<UserModel> get userStream {
    return _firebaseAuth.userChanges().map((firebaseUser) {
      final user =
          firebaseUser == null ? UserModel.empty : firebaseUser.toUserModel;
      return user;
    });
  }

  @override
  Future<void> login({required String phoneNumber}) async {
    try {
      _phoneNumber = phoneNumber;
      // Need to check if user exists. If not, does not send allow to send OTP
      if (!await _isUserExist(phoneNumber: phoneNumber)) {
        throw const LoginFailure(code: 'user-not-found');
      }

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
        },
      );
    } on FirebaseAuthException catch (e) {
      logger.e('login error, exception: $e');
      throw LoginFailure(code: e.code);
    } on LoginFailure catch (_) {
      rethrow;
    } catch (e) {
      logger.e('login unknown error, exception: $e');
      throw const LoginFailure();
    }
  }

  Future<bool> _isUserExist({required String phoneNumber}) async {
    final querySnapshot = await _firestore
        .collection('user_check')
        .where('phone', isEqualTo: phoneNumber)
        .get();

    logger.d("Successfully completed ${querySnapshot.size}");

    if (querySnapshot.size < 1) {
      return false;
    }

    for (var docSnapshot in querySnapshot.docs) {
      logger.d('${docSnapshot.id} => ${docSnapshot.data()}');
    }

    return true;
  }

  @override
  Future<void> verifyOtp({required String otp}) async {
    logger.d('verifyOtp, otp: $otp');
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: otp);
      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      logger.e('verifyOtp error, exception: $e');
      throw LoginFailure(code: e.code);
    } catch (e) {
      logger.e('verifyOtp unknown error, exception: $e');
      throw const LoginFailure();
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
      logger.e('resendOtp error, exception: $e');
      throw LoginFailure(code: e.code);
    } catch (e) {
      logger.e('resendOtp unknown error, exception: $e');
      throw const LoginFailure();
    }
  }

  @override
  Future<void> logout() async {
    logger.d('logout');
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (e) {
      logger.e('logout error, exception: $e');
      throw LogOutFailure();
    }
  }

  @override
  Future<void> updateUsername(String username) {
    throw UnimplementedError();
  }

  @override
  Future<String> uploadAvatar(String uri) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserAvatar(String photoUrl) {
    throw UnimplementedError();
  }
}
