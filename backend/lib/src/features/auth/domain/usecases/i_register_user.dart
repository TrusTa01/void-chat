import 'package:backend/src/features/auth/domain/entities/user_entity.dart';
import 'package:backend/src/features/auth/domain/value_objects/new_user.dart';

abstract interface class IRegisterUser {
  Future<UserEntity> call(NewUser data);
}
