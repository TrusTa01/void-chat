import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:void_chat/core/storage/secure_storage/app_secure_storage.dart';

enum AuthStatus { initial, authenticated, unauthenticated }

@lazySingleton
class AuthCubit extends Cubit<AuthStatus> {
  final AppSecureStorage _secureStorage;

  AuthCubit(this._secureStorage) : super(AuthStatus.initial);

  Future<void> checkAuth() async {
    final token = await _secureStorage.getToken();
    if (token != null) {
      emit(AuthStatus.authenticated);
    } else {
      emit(AuthStatus.unauthenticated);
    }
  }

  void setAuthenticated() => emit(AuthStatus.authenticated);
  void setUnauthenticated() => emit(AuthStatus.unauthenticated);

  void logout() {
    _secureStorage.deleteToken();
    setUnauthenticated();
  }
}
