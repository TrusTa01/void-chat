import 'package:backend/src/core/api/json_response.dart';
import 'package:backend/src/features/auth/shared/mappers/parse_body.dart';
import 'package:backend/src/features/auth/login/api/mappers/login_response_mapper.dart';
import 'package:backend/src/features/auth/login/api/mappers/parse_login_body.dart';
import 'package:backend/src/features/auth/register/api/mappers/parse_register_body.dart';
import 'package:backend/src/features/auth/register/api/mappers/register_response_mapper.dart';
import 'package:backend/src/features/auth/domain/usecases/i_register_user.dart';
import 'package:backend/src/features/auth/domain/usecases/login_user.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

@lazySingleton
class AuthApi {
  final ILoginUser _loginUser;
  final IRegisterUser _registerUserUseCase;

  AuthApi(this._loginUser, this._registerUserUseCase);

  late final Router router = _buildRouter();

  Router _buildRouter() {
    final r = Router();

    r.post('/login', (Request request) => _loginHandler(request));
    r.post('/register', (Request request) => _registerHandler(request));

    return r;
  }

  Future<Response> _loginHandler(Request request) async {
    final body = await request.readAsString();
    final decoded = parseBody(body);
    final dto = parseLoginBody(decoded);
    final result = await _loginUser.call(dto.identifier, dto.password);
    final response = result.toLoginResponse();
    return JsonResponse.ok(response.toJson());
  }

  Future<Response> _registerHandler(Request request) async {
    final body = await request.readAsString();
    final decoded = parseBody(body);
    final dto = parseRegisterBody(decoded);
    final result = await _registerUserUseCase.call(dto);
    final response = result.toRegisterResponse();
    return JsonResponse.created(response.toJson());
  }
}
