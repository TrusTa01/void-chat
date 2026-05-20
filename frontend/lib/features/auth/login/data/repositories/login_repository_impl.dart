import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:void_chat/core/network/errors/api_exception.dart';
import 'package:void_chat/core/storage/secure_storage/app_secure_storage.dart';
import 'package:void_chat/features/auth/login/data/data_sources/login_remote_data_source.dart';
import 'package:void_chat/features/auth/login/domain/failures/login_failure.dart';
import 'package:void_chat/features/auth/login/domain/repositories/i_login_repository.dart';
import 'package:void_chat/features/auth/shared/domain/entities/user_entity.dart';

@LazySingleton(as: ILoginRepository)
class LoginRepositoryImpl implements ILoginRepository {
  final LoginRemoteDataSource _dataSource;
  final AppSecureStorage _secureStorage;

  const LoginRepositoryImpl(
    this._dataSource,
    this._secureStorage,
  );

  @override
  Future<UserEntity> loginWithPassword(
    String identifier,
    String password,
  ) async {
    try {
      final response = await _dataSource.loginWithPassword(
        identifier: identifier,
        password: password,
      );

      await _secureStorage.saveToken(response.accessToken);
      
      final user = response.user;
      return UserEntity(
        id: user.id,
        email: user.email,
        username: user.username,
        displayName: user.displayName,
        createdAt: user.createdAt,
      );
    } on DioException catch (e) {
      final api = e.error;
      if (api is ApiException) {
        switch (api.code) {
          case 'INVALID_CREDENTIALS':
            throw const InvalidCredentialsFailure();
          default:
            throw UnknownLoginFailure(api.message);
        }
      }
      throw const NetworkFailure();
    }
  }
}
