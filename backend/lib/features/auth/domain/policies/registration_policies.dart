import 'package:backend/core/errors/app_exception.dart';
import 'package:backend/features/auth/auth_error_codes.dart';
import 'package:backend/features/auth/domain/policies/auth_registration_blacklists.dart';
import 'package:injectable/injectable.dart';

/// Returns [login] if policy allows it; otherwise throws [ValidationException].
abstract interface class LoginPolicy {
  String ensure(String login);
}

/// Returns [username] if policy allows it; otherwise throws [ValidationException].
abstract interface class UsernamePolicy {
  String ensure(String username);
}

/// Returns [email] unchanged if allowed; otherwise throws [ValidationException].
abstract interface class EmailPolicy {
  String ensure(String email);
}

/// Returns [displayName] if allowed; otherwise throws [ValidationException].
abstract interface class DisplayNamePolicy {
  String ensure(String displayName);
}

@LazySingleton(as: LoginPolicy)
class BlacklistLoginPolicy implements LoginPolicy {
  const BlacklistLoginPolicy();

  @override
  String ensure(String login) {
    if (kReservedLogins.contains(login.toLowerCase())) {
      throw const ValidationException(
        AuthErrorCodes.reservedLogin,
        'This login is not available',
      );
    }
    return login;
  }
}

@LazySingleton(as: UsernamePolicy)
class BlacklistUsernamePolicy implements UsernamePolicy {
  const BlacklistUsernamePolicy();

  @override
  String ensure(String username) {
    if (kReservedUsernames.contains(username.toLowerCase())) {
      throw const ValidationException(
        AuthErrorCodes.reservedUsername,
        'This username is not available',
      );
    }
    return username;
  }
}

@LazySingleton(as: EmailPolicy)
class BlocklistEmailPolicy implements EmailPolicy {
  const BlocklistEmailPolicy();

  @override
  String ensure(String email) {
    final lower = email.toLowerCase();

    if (kBlockedFullEmails.contains(lower)) {
      throw const ValidationException(
        AuthErrorCodes.blockedEmail,
        'This email address cannot be used for registration',
      );
    }

    final at = lower.indexOf('@');
    if (at <= 0 || at == lower.length - 1) {
      return email;
    }

    final local = lower.substring(0, at);
    final domain = lower.substring(at + 1);

    if (kBlockedEmailLocalParts.contains(local)) {
      throw const ValidationException(
        AuthErrorCodes.blockedEmail,
        'This email address cannot be used for registration',
      );
    }

    if (kBlockedEmailDomains.contains(domain)) {
      throw const ValidationException(
        AuthErrorCodes.blockedEmail,
        'This email provider is not accepted',
      );
    }

    return email;
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
  String ensure(String displayName) {
    if (kReservedDisplayNames.contains(_normalize(displayName))) {
      throw const ValidationException(
        AuthErrorCodes.reservedDisplayName,
        'This display name is reserved',
      );
    }
    return displayName;
  }
}
