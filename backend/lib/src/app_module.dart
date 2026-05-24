import 'package:backend/src/core/api/json_response.dart';
import 'package:backend/src/features/auth/auth_controller.dart';
import 'package:backend/src/features/chat/chat_controller.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

@lazySingleton
class AppModule {
  final Router _rootRouter;
  final AuthApi _authApi;
  final ChatApi _chatApi;

  late final Handler handler = _buildHandler();

  AppModule(this._rootRouter, this._authApi, this._chatApi);

  Handler _buildHandler() {
    _rootRouter.get('/', _rootHandler);
    _rootRouter.get('/health', _healthHandler);
    _rootRouter.get('/favicon.ico', (_) => Response(204));

    _rootRouter.mount('/auth/', _authApi.router.call);

    _rootRouter.mount('/chat/', _chatApi.router.call);

    return _rootRouter.call;
  }

  Response _rootHandler(Request _) => JsonResponse.ok({
    'service': 'backend',
    'status': 'ok',
    'health': '/health',
    'api': '/auth/',
  });

  Response _healthHandler(Request _) => JsonResponse.ok({'status': 'ok'});
}
