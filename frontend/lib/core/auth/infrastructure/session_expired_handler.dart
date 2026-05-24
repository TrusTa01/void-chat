import 'package:injectable/injectable.dart';
import 'package:void_chat/core/auth/infrastructure/i_session_expired_handler.dart';
import 'package:void_chat/features/auth/shared/presentation/cubit/auth_cubit.dart';

@LazySingleton(as: ISessionExpiredHandler)
class SessionExpiredHandlerImpl implements ISessionExpiredHandler {
  final AuthCubit _authCubit;

  const SessionExpiredHandlerImpl(this._authCubit);

  @override
  void onSessionExpired() => _authCubit.logout();
}
