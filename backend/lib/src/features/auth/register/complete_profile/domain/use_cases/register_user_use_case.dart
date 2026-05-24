import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/register/complete_profile/api/dto/request/complete_profile_request_dto.dart';
import 'package:backend/src/features/auth/register/complete_profile/domain/repositories/i_complete_profile_repository.dart';
import 'package:backend/src/features/auth/register/complete_profile/domain/use_cases/validate_complete_profile_input_use_case.dart';
import 'package:backend/src/features/auth/shared/auth_error_codes.dart';
import 'package:backend/src/features/auth/shared/domain/entities/user_entity.dart';
import 'package:backend/src/features/auth/login/password/domain/repositories/i_user_repository.dart';
import 'package:backend/src/features/auth/register/complete_profile/domain/value_objects/new_user.dart';
import 'package:injectable/injectable.dart';

abstract interface class ICompleteRegistrationProfileUseCase {
  Future<UserEntity> call(CompleteProfileRequestDto data);
}

@LazySingleton(as: ICompleteRegistrationProfileUseCase)
class CompleteRegistrationProfileUseCase
    implements ICompleteRegistrationProfileUseCase {
  final ICompleteProfileRepository _completeProfileRepo;
  final IUserRepository _userRepo;
  final IValidateCompleteProfileInputUseCase _validateInput;

  const CompleteRegistrationProfileUseCase(
    this._completeProfileRepo,
    this._userRepo,
    this._validateInput,
  );

  @override
  Future<UserEntity> call(CompleteProfileRequestDto data) async {
    final pending = await _completeProfileRepo.findForCompletionById(
      data.registrationId,
    );

    if (pending == null) {
      throw const ValidationException(
        AuthErrorCodes.invalidRegistration,
        'Registration was not found',
      );
    }

    if (pending.verifiedAt == null) {
      throw const ValidationException(
        AuthErrorCodes.emailNotVerified,
        'Email must be verified before completing profile',
      );
    }

    final validInput = _validateInput(data);

    final record = await _userRepo.create(
      NewUserRecord(
        login: pending.login,
        passwordHash: pending.passwordHash,
        email: pending.email,
        username: validInput.username,
        displayName: validInput.displayName,
      ),
    );
    await _completeProfileRepo.deleteById(data.registrationId);

    return record;
  }
}
