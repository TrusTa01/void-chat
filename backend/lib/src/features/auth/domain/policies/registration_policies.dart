import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:backend/src/features/auth/shared/auth_field_names.dart';
import 'package:backend/src/features/auth/domain/policies/auth_registration_blacklists.dart';
import 'package:injectable/injectable.dart';

/// Returns `true` if the value passes the policy. Otherwise appends a
/// [FieldError] to [errors] and returns `false`
abstract interface class LoginPolicy {
  bool check(String login, List<FieldError> errors);
}

abstract interface class UsernamePolicy {
  bool check(String username, List<FieldError> errors);
}

abstract interface class EmailPolicy {
  bool check(String email, List<FieldError> errors);
}

abstract interface class DisplayNamePolicy {
  bool check(String displayName, List<FieldError> errors);
}

@LazySingleton(as: LoginPolicy)
class BlacklistLoginPolicy implements LoginPolicy {
  const BlacklistLoginPolicy();

  @override
  bool check(String login, List<FieldError> errors) {
    if (kReservedLogins.contains(login.toLowerCase())) {
      errors.add(
        const FieldError(
          field: AuthFieldNames.login,
          code: AuthErrorCodes.invalidLogin,
          message: 'This login is not available',
        ),
      );
      return false;
    }
    return true;
  }
}

@LazySingleton(as: UsernamePolicy)
class BlacklistUsernamePolicy implements UsernamePolicy {
  const BlacklistUsernamePolicy();

  @override
  bool check(String username, List<FieldError> errors) {
    if (kReservedUsernames.contains(username.toLowerCase())) {
      errors.add(
        const FieldError(
          field: AuthFieldNames.username,
          code: AuthErrorCodes.invalidUsername,
          message: 'This username is not available',
        ),
      );
      return false;
    }
    return true;
  }
}

@LazySingleton(as: EmailPolicy)
class BlocklistEmailPolicy implements EmailPolicy {
  const BlocklistEmailPolicy();

  @override
  bool check(String email, List<FieldError> errors) {
    final lower = email.toLowerCase();

    if (kBlockedFullEmails.contains(lower)) {
      errors.add(
        const FieldError(
          field: AuthFieldNames.email,
          code: AuthErrorCodes.invalidEmail,
          message: 'This email address cannot be used for registration',
        ),
      );
      return false;
    }

    final at = lower.indexOf('@');
    // Defensive: malformed addresses are caught earlier by the validator;
    // here we just skip local/domain checks to avoid false positives
    if (at <= 0 || at == lower.length - 1) {
      return true;
    }

    final local = lower.substring(0, at);
    final domain = lower.substring(at + 1);

    if (kBlockedEmailLocalParts.contains(local)) {
      errors.add(
        const FieldError(
          field: AuthFieldNames.email,
          code: AuthErrorCodes.invalidEmail,
          message: 'This email address cannot be used for registration',
        ),
      );
      return false;
    }

    if (kBlockedEmailDomains.contains(domain)) {
      errors.add(
        const FieldError(
          field: AuthFieldNames.email,
          code: AuthErrorCodes.invalidEmail,
          message: 'This email provider is not accepted',
        ),
      );
      return false;
    }

    return true;
  }
}

/// Normalizes display name whitespace, lowercases, and checks exact blocklist hits.
@LazySingleton(as: DisplayNamePolicy)
class ReservedDisplayNamePolicy implements DisplayNamePolicy {
  const ReservedDisplayNamePolicy();

  static String _normalize(String displayName) {
    return displayName.toLowerCase().trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  @override
  bool check(String displayName, List<FieldError> errors) {
    if (kReservedDisplayNames.contains(_normalize(displayName))) {
      errors.add(
        const FieldError(
          field: AuthFieldNames.displayName,
          code: AuthErrorCodes.invalidDisplayName,
          message: 'This display name is reserved',
        ),
      );
      return false;
    }
    return true;
  }
}
