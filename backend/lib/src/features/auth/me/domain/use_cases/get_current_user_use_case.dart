import 'package:backend/src/core/errors/app_exception.dart';
import 'package:backend/src/features/auth/login/password/domain/repositories/i_user_repository.dart';
import 'package:backend/src/features/auth/shared/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';

abstract interface class IGetCurrentUserUseCase {
  Future<UserEntity> call(String userId);
}

@LazySingleton(as: IGetCurrentUserUseCase)
class GetCurrentUserUseCase implements IGetCurrentUserUseCase {
  final IUserRepository _users;

  const GetCurrentUserUseCase(this._users);

  @override
  Future<UserEntity> call(String userId) async {
    final user = await _users.findById(userId);
    return user ??
        (throw const InternalServerException(
          'USER_NOT_FOUND',
          'Authenticated user no longer exists',
        ));
  }
}
