import 'package:shelf/shelf.dart';
import 'package:talker/talker.dart';

abstract class LoggingMiddleware {
  static Middleware talkerMiddleware(Talker talker) {
    return (Handler innerHandle) {
      return (Request request) async {
        talker.info('[${request.method}] ${request.requestedUri.path}');

        try {
          final response = await innerHandle(request);
          talker.info('Response: ${response.statusCode}');
          return response;
        } on HijackException {
          rethrow;
        } catch (e, st) {
          talker.handle(e, st, 'Server error');
          rethrow;
        }
      };
    };
  }
}
