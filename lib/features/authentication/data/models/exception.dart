class LoginWithGoogleFailure implements Exception {
  const LoginWithGoogleFailure([
    this.message = 'An unknown exception occured.',
  ]);

  factory LoginWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        {
          return const LoginWithGoogleFailure(
            'Account exists with different credentials.',
          );
        }
      case 'invalid-credential':
        {
          return const LoginWithGoogleFailure(
            'The credential received is malformed or has expired.',
          );
        }
      case 'operation-not-allowed':
        {
          return const LoginWithGoogleFailure(
            'Operation is not allowed.  Please contact support.',
          );
        }
      case 'user-disabled':
        {
          return const LoginWithGoogleFailure(
            'This user has been disabled. Please contact support for help.',
          );
        }
      case 'user-not-found':
        {
          return const LoginWithGoogleFailure(
            'Email is not found, please create an account.',
          );
        }
      case 'wrong-password':
        {
          return const LoginWithGoogleFailure(
            'Incorrect password, please try again.',
          );
        }
      case 'invalid-verification-code':
        {
          return const LoginWithGoogleFailure(
            'The credential verification code received is invalid.',
          );
        }
      case 'invalid-verification-id':
        {
          return const LoginWithGoogleFailure(
            'The credential verification ID received is invalid.',
          );
        }
      default:
        return const LoginWithGoogleFailure();
    }
  }

  final String message;
}

class LogInWithEmailAndPasswordFailure implements Exception {
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

class SignUpWithEmailAndPasswordFailure implements Exception {
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

class LogOutFailure implements Exception {}
