import 'package:void_chat/core/l10n/gen/app_localizations.dart';

/// Matches [backend/lib/src/features/auth/shared/services/email_code.dart].
const int verificationCodeLength = 4;

final RegExp _verificationCodeDigits = RegExp(r'^\d+$');

String? validateVerificationCode(String? value, AppLocalizations l10n) {
  final raw = value ?? '';
  if (raw.isEmpty) {
    return l10n.verifyEmailCodeRequired;
  }
  if (raw.length != verificationCodeLength) {
    return l10n.verifyEmailCodeIncomplete;
  }
  if (!_verificationCodeDigits.hasMatch(raw)) {
    return l10n.verifyEmailCodeInvalid;
  }
  return null;
}
