import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/register/complete_profile/api/dto/request/complete_profile_request_dto.dart';
import 'package:backend/src/features/auth/register/complete_profile/domain/use_cases/validate_complete_profile_input_use_case.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:backend/src/features/auth/shared/auth_field_names.dart';
import 'package:backend/src/features/auth/register/shared/domain/policies/registration_policies.dart';
import 'package:test/test.dart';

void main() {
  late ValidateCompleteProfileInputUseCase useCase;

  setUp(() {
    useCase = const ValidateCompleteProfileInputUseCase(
      BlacklistUsernamePolicy(),
      ReservedDisplayNamePolicy(),
    );
  });

  group('ValidateCompleteProfileInputUseCase', () {
    test('returns normalized username and display name', () {
      final result = useCase(
        const CompleteProfileRequestDto(
          registrationId: 'registration-123',
          username: ' john_doe ',
          displayName: ' John Doe ',
        ),
      );

      expect(result.username, 'john_doe');
      expect(result.displayName, 'John Doe');
    });

    test('rejects invalid username format', () {
      final exception = _captureValidationFailure(
        () => useCase(
          const CompleteProfileRequestDto(
            registrationId: 'registration-123',
            username: 'john!!!',
            displayName: 'John Doe',
          ),
        ),
      );

      expect(exception.details, hasLength(1));
      expect(exception.details.single.field, AuthFieldNames.username);
      expect(exception.details.single.code, AuthErrorCodes.invalidUsername);
    });

    test('rejects empty display name', () {
      final exception = _captureValidationFailure(
        () => useCase(
          const CompleteProfileRequestDto(
            registrationId: 'registration-123',
            username: 'john_doe',
            displayName: '   ',
          ),
        ),
      );

      expect(exception.details, hasLength(1));
      expect(exception.details.single.field, AuthFieldNames.displayName);
      expect(exception.details.single.code, AuthErrorCodes.invalidDisplayName);
    });

    test('rejects reserved username through policy', () {
      final exception = _captureValidationFailure(
        () => useCase(
          const CompleteProfileRequestDto(
            registrationId: 'registration-123',
            username: 'admin',
            displayName: 'John Doe',
          ),
        ),
      );

      expect(exception.details, hasLength(1));
      expect(exception.details.single.field, AuthFieldNames.username);
      expect(exception.details.single.code, AuthErrorCodes.invalidUsername);
    });
  });
}

ValidationFailedException _captureValidationFailure(void Function() action) {
  try {
    action();
  } on ValidationFailedException catch (e) {
    return e;
  }

  fail('Expected ValidationFailedException');
}
