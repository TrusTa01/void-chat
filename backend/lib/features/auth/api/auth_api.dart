import 'package:backend/core/api/json_response.dart';
import 'package:backend/features/auth/api/mappers/register_request_mapper.dart';
import 'package:backend/features/auth/api/mappers/register_response_mapper.dart';
import 'package:backend/features/auth/domain/usecases/register_user.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

@lazySingleton
class AuthApi {
  final IRegisterUser _registerUserUseCase;

  AuthApi(this._registerUserUseCase);

  late final Router router = _buildRouter();

  Router _buildRouter() {
    final r = Router();

    r.post('/login', (Request request) async => Response.ok('ok'));

    r.post('/register', (Request request) async => _registerHandler(request));

    return r;
  }

  Future<Response> _registerHandler(Request request) async {
    final body = await request.readAsString();
    final newUser = parseRegisterBody(body);
    final user = await _registerUserUseCase.call(newUser);
    final response = user.toRegisterResponse();

    return JsonResponse.created(response.toJson());
  }
}
