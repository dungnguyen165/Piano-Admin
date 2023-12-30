class LogInWithPhoneNumberFailure implements Exception {
  const LogInWithPhoneNumberFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithPhoneNumberFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithPhoneNumberFailure(
          'Account is already existed. Please contact support for help.',
        );
      case 'invalid-credential':
        return const LogInWithPhoneNumberFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'operation-not-allowed':
        return const LogInWithPhoneNumberFailure(
          'Login by phone number is not allowed. Please contact support for help.',
        );
      case 'user-disabled':
        return const LogInWithPhoneNumberFailure(
          'This user has been disabled.',
        );
      case 'user-not-found':
        return const LogInWithPhoneNumberFailure(
          'Cannot find user.',
        );
      case 'wrong-password':
        return const LogInWithPhoneNumberFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithPhoneNumberFailure(
          'Incorrect verify code, please try again.',
        );
      case 'invalid-verification-id':
        return const LogInWithPhoneNumberFailure(
          'Incorrect verify code, please try again.',
        );
      default:
        return const LogInWithPhoneNumberFailure();
    }
  }

  /// The associated error message.
  final String message;
}

class LogOutFailure implements Exception {}
