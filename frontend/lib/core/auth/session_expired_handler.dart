import 'package:injectable/injectable.dart';
import 'package:void_chat/core/auth/auth_cubit.dart';

abstract interface class ISessionExpiredHandler {
  void onSessionExpired();
}

@LazySingleton(as: ISessionExpiredHandler)
class SessionExpiredHandlerImpl implements ISessionExpiredHandler {
  final AuthCubit _authCubit;

  const SessionExpiredHandlerImpl(this._authCubit);

  @override
  void onSessionExpired() => _authCubit.logout();
}