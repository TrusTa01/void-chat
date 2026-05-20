import 'package:void_chat/features/auth/shared/domain/entities/user_entity.dart';

abstract interface class ILoginRepository {
  Future<UserEntity> loginWithPassword(String identifier, String password);
}
