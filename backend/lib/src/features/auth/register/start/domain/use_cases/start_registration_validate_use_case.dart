import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/domain/policies/registration_policies.dart';
import 'package:backend/src/features/auth/domain/validators/new_user_validator.dart';
import 'package:backend/src/features/auth/register/start/api/dto/request/start_registration_request_dto.dart';
import 'package:backend/src/features/auth/shared/auth_field_names.dart';
import 'package:injectable/injectable.dart';

abstract interface class IStartRegistrationValidateUseCase {
  Future<void> validate(StartRegistrationRequestDto data);
}

@LazySingleton(as: IStartRegistrationValidateUseCase)
class StartRegistrationValidateUseCase
    implements IStartRegistrationValidateUseCase {
  final LoginPolicy _loginPolicy;
  final EmailPolicy _emailPolicy;

  StartRegistrationValidateUseCase(this._loginPolicy, this._emailPolicy);

  @override
  Future<void> validate(StartRegistrationRequestDto data) async {
    final validation = validateStartRegistrationInput(
      login: data.login,
      email: data.email,
      password: data.password,
    );
    final errors = validation.errors;
    final normalized = validation.normalized;

    if (!_hasFieldError(errors, AuthFieldNames.login)) {
      _loginPolicy.check(normalized.login, errors);
    }
    if (!_hasFieldError(errors, AuthFieldNames.email)) {
      _emailPolicy.check(normalized.email, errors);
    }

    if (errors.isNotEmpty) {
      throw ValidationFailedException(errors);
    }
  }

  bool _hasFieldError(List<FieldError> errors, String field) =>
      errors.any((error) => error.field == field);
}
