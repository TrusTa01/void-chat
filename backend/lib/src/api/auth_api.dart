import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

@lazySingleton
class AuthApi {
  late final Router router = _buildRouter();

  Router _buildRouter() {
    final r = Router();

    r.get('/login', (Request request) async {
      return Response.ok('Вход в систему');
    });

    r.post('/register', (Request request) async {
      return Response.ok('Регистрация запущена');
    });

    return r;
  }
}
