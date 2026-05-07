import 'package:injectable/injectable.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:talker/talker.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Router get router => Router();
  
  @lazySingleton
  Talker get talker => Talker();
}
