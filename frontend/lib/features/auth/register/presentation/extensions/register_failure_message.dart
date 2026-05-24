import 'package:void_chat/core/l10n/gen/app_localizations.dart';
import 'package:void_chat/features/auth/login/domain/failures/login_failure.dart';
import 'package:void_chat/features/auth/login/presentation/extensions/login_failure_message.dart';
import 'package:void_chat/features/auth/register/domain/failures/register_failure.dart';

extension RegisterFailureMessage on RegisterFailure {
  String messages(AppLocalizations l10n) => switch (this) {
    EmailTakenFailure() => l10n.registerEmailTaken,
    UsernameTakenFailure() => l10n.registerUsernameTaken,
    InvalidRegistrationFailure() => l10n.registerInvalidRegistration,
    EmailNotVerifiedFailure() => l10n.registerEmailNotVerified,
    RegisterEmailCodeFailure(:final type) => switch (type) {
      RegisterEmailCodeError.invalid => l10n.loginEmailCodeInvalid,
      RegisterEmailCodeError.expired => l10n.loginEmailCodeExpired,
      RegisterEmailCodeError.attemptsExceeded =>
        l10n.loginEmailCodeAttemptsExceeded,
    },
    RegisterResendTooSoonFailure() => l10n.loginEmailCodeResendTooSoon,
    RegisterNetworkFailure() => l10n.networkError,
    UnknownRegisterFailure(:final message) => message,
    RegisterAutoLoginFailure(:final cause) =>
      cause is LoginFailure ? cause.messages(l10n) : l10n.networkError,
  };
}
