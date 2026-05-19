import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/register/complete_profile/api/dto/request/complete_profile_request_dto.dart';
import 'package:backend/src/features/auth/shared/auth_field_names.dart';
import 'package:backend/src/features/auth/shared/domain/policies/registration_policies.dart';
import 'package:backend/src/features/auth/shared/domain/validators/new_user_validator.dart';
import 'package:injectable/injectable.dart';

final class ValidCompleteProfileInput {
  final String username;
  final String displayName;

  const ValidCompleteProfileInput({
    required this.username,
    required this.displayName,
  });
}

abstract interface class IValidateCompleteProfileInputUseCase {
  ValidCompleteProfileInput call(CompleteProfileRequestDto data);
}

@LazySingleton(as: IValidateCompleteProfileInputUseCase)
class ValidateCompleteProfileInputUseCase
    implements IValidateCompleteProfileInputUseCase {
  final UsernamePolicy _usernamePolicy;
  final DisplayNamePolicy _displayNamePolicy;

  const ValidateCompleteProfileInputUseCase(
    this._usernamePolicy,
    this._displayNamePolicy,
  );

  @override
  ValidCompleteProfileInput call(CompleteProfileRequestDto data) {
    final validation = validateCompleteProfileInput(
      username: data.username,
      displayName: data.displayName,
    );
    final errors = validation.errors;
    final normalized = validation.normalized;

    if (!_hasFieldError(errors, AuthFieldNames.username)) {
      _usernamePolicy.check(normalized.username, errors);
    }
    if (!_hasFieldError(errors, AuthFieldNames.displayName)) {
      _displayNamePolicy.check(normalized.displayName, errors);
    }

    if (errors.isNotEmpty) {
      throw ValidationFailedException(errors);
    }

    return ValidCompleteProfileInput(
      username: normalized.username,
      displayName: normalized.displayName,
    );
  }

  bool _hasFieldError(List<FieldError> errors, String field) =>
      errors.any((error) => error.field == field);
}
