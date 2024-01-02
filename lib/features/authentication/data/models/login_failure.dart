import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogInWithPhoneNumberFailure implements Exception {
  const LogInWithPhoneNumberFailure({this.code = 'unknown'});

  final String code;

  /// The associated error message.
  String get message {
    switch (code) {
      case 'account-exists-with-different-credential':
        return 'Account is already existed. Please contact support for help.';
      case 'invalid-credential':
      case 'user-disabled':
        return 'This user has been disabled. Please contact support for help.';
      case 'operation-not-allowed':
        return 'Login by phone number is not allowed. Please contact support for help.';
      case 'user-not-found':
        return 'Cannot find user.';
      case 'wrong-password':
        return 'Incorrect password, please try again.';
      case 'invalid-verification-code':
      case 'invalid-verification-id':
        return 'Incorrect verify code, please try again.';
      default:
        return 'An unknown exception occurred.';
    }
  }

  String localizedMessage(BuildContext context) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return AppLocalizations.of(context).errorMessageAccountIsAlreadyExisted;
      case 'invalid-credential':
      case 'user-disabled':
        return AppLocalizations.of(context).errorMessageUserHasBeenDisabled;
      case 'operation-not-allowed':
        return AppLocalizations.of(context)
            .errorMessageLoginByPhoneNumberIsNotAllowed;
      case 'user-not-found':
        return AppLocalizations.of(context).errorMessageCannotFindUser;
      case 'wrong-password':
        return AppLocalizations.of(context).errorMessageIncorrectPassword;
      case 'invalid-verification-code':
      case 'invalid-verification-id':
        return AppLocalizations.of(context).errorMessageIncorrectVerifyCode;
      default:
        return AppLocalizations.of(context).errorMessageAnUnknownErrorOccurred;
    }
  }
}

class LogOutFailure implements Exception {}
