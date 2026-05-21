import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EmailCodeResendPolicy {
  static const resendCooldownS60 = Duration(seconds: 60);

  void ensureAllowed(DateTime? lastSent) {
    if (lastSent != null) {
      final elapsed = DateTime.now().toUtc().difference(lastSent.toUtc());
      if (elapsed < resendCooldownS60) {
        throw const TooManyRequestsException(
          AuthErrorCodes.emailCodeResendTooSoon,
          'Please wait before requesting a new code',
        );
      }
    }
  }
}
