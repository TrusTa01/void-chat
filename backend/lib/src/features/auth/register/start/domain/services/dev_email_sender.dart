import 'package:backend/src/features/auth/register/start/domain/services/i_email_sender.dart';
import 'package:injectable/injectable.dart';
import 'package:talker/talker.dart';

@LazySingleton(as: EmailCodeSenderService)
class DevEmailSender implements EmailCodeSenderService {
  final Talker _talker;

  DevEmailSender(this._talker);

  @override
  Future<void> send(String email, String code) async {
    _talker.info('Registration code for $email: $code');
  }
}
