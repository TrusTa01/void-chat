import 'package:void_chat/features/auth/shared/domain/entities/user_entity.dart';

abstract interface class IRegisterRepository {
  Future<String> startRegistration({
    required String login,
    required String email,
    required String password,
  });

  Future<void> verifyRegistrationEmail({
    required String registrationId,
    required String code,
  });

  Future<UserEntity> completeRegistration({
    required String registrationId,
    required String username,
    required String displayName,
  });

  Future<void> cancelRegistration({required String registrationId});
}
