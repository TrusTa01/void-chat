import 'package:backend/src/features/auth/auth_controller.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

@lazySingleton
class AppModule {
  final Router _rootRouter;
  final AuthApi _authApi;

  late final Handler handler = _buildHandler();

  AppModule(this._rootRouter, this._authApi);

  Handler _buildHandler() {
    _rootRouter.mount('/auth/', _authApi.router.call);

    return _rootRouter.call;
  }
}
