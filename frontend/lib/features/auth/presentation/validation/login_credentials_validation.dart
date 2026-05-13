import 'package:flutter/services.dart';
import 'package:void_chat/core/l10n/gen/app_localizations.dart';

/// Mirrors [backend/lib/src/features/auth/domain/validators/new_user_validator.dart]
/// and README: login identifier is the same `login` or `email` used at registration.
const int loginIdentifierMaxLength = 254;
const int loginLoginMinLength = 3;
const int loginLoginMaxLength = 64;
const int loginPasswordMinLength = 8;
const int loginPasswordMaxLength = 128;

final RegExp _loginCharset = RegExp(r'^[a-zA-Z0-9_-]+$');

/// Same pragmatic pattern as the backend (not full RFC 5322).
final RegExp _emailShape = RegExp(
  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$",
);

final RegExp _passwordHasLetter = RegExp(r'\p{L}', unicode: true);
final RegExp _passwordHasDigit = RegExp(r'\p{N}', unicode: true);

/// Disallows ASCII control characters and newlines (identifier is a single line).
final RegExp _identifierDeniedChars = RegExp(
  r'[\r\n\x00-\x08\x0B\x0C\x0E-\x1F\x7F]',
);

final List<TextInputFormatter> loginIdentifierInputFormatters = [
  LengthLimitingTextInputFormatter(loginIdentifierMaxLength),
  FilteringTextInputFormatter.deny(_identifierDeniedChars),
];

final List<TextInputFormatter> loginPasswordInputFormatters = [
  LengthLimitingTextInputFormatter(loginPasswordMaxLength),
  FilteringTextInputFormatter.deny(_identifierDeniedChars),
];

String? validateLoginIdentifier(String? value, AppLocalizations l10n) {
  final trimmed = value?.trim() ?? '';
  if (trimmed.isEmpty) {
    return l10n.loginIdentifierRequired;
  }
  if (trimmed.length > loginIdentifierMaxLength) {
    return l10n.loginIdentifierTooLong;
  }
  if (trimmed.contains('@')) {
    if (!_emailShape.hasMatch(trimmed)) {
      return l10n.loginIdentifierInvalidEmail;
    }
    return null;
  }
  if (trimmed.length < loginLoginMinLength ||
      trimmed.length > loginLoginMaxLength) {
    return l10n.loginIdentifierInvalidLoginLength;
  }
  if (!_loginCharset.hasMatch(trimmed)) {
    return l10n.loginIdentifierInvalidLoginChars;
  }
  return null;
}

String? validateLoginPassword(String? value, AppLocalizations l10n) {
  final raw = value ?? '';
  if (raw.isEmpty) {
    return l10n.loginPasswordRequired;
  }
  if (raw.length < loginPasswordMinLength ||
      raw.length > loginPasswordMaxLength) {
    return l10n.loginPasswordLength;
  }
  if (!_passwordHasLetter.hasMatch(raw) || !_passwordHasDigit.hasMatch(raw)) {
    return l10n.loginPasswordLetterAndDigit;
  }
  return null;
}
