import 'package:injectable/injectable.dart';
import 'package:talker/talker.dart';

@module
abstract class RegisterModule {
  @singleton
  Talker get talker => Talker();
}
