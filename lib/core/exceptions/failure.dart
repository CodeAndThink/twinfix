import 'package:twinfix/generated/l10n.dart';
import 'package:twinfix/core/constants/key_constants.dart';

class Failure implements Exception {
  final String message;
  Failure(this.message);

  factory Failure.fromCode(String code) {
    switch (code) {
      case KeyConstants.invalidCredentials:
        return Failure(S.current.loginFailureMessage);
      case KeyConstants.userAlreadyExists:
      case KeyConstants.emailExists:
        return Failure(S.current.emailAlreadyInUse);
      case KeyConstants.weakPassword:
        return Failure(S.current.weakPassword);
      case KeyConstants.userBanned:
        return Failure(S.current.userBanned);
      case KeyConstants.userNotFound:
        return Failure(S.current.userNotFound);
      case KeyConstants.emailNotConfirmed:
        return Failure(S.current.emailNotConfirmed);
      case KeyConstants.overRateLimit:
        return Failure(S.current.tooManyRequests);
      default:
        return Failure(S.current.defaultErrorMessage);
    }
  }

  @override
  String toString() => message;
}
