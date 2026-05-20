import 'package:void_chat/core/l10n/gen/app_localizations.dart';
import 'package:void_chat/features/auth/login/domain/failures/login_failure.dart';

extension LoginFailureMessage on LoginFailure {
  String messages(AppLocalizations l10n) => switch (this) {
    InvalidCredentialsFailure() => l10n.loginInvalidCredential,
    NetworkFailure() => l10n.networkError,
    UnknownLoginFailure(:final message) => message,
  };
}
