import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EmailCodeResendCooldown {
  final bool canResend;
  final int secondsLeft;
  final VoidCallback startCooldown;

  const EmailCodeResendCooldown({
    required this.canResend,
    required this.secondsLeft,
    required this.startCooldown,
  });
}

/// Countdown for "resend code" links. Sync [cooldown] with the backend policy.
EmailCodeResendCooldown useEmailCodeResendCooldown({
  /// Must match [EmailCodeResendPolicy.resendCooldownS60] on the backend
  Duration cooldown = const Duration(seconds: 60),

  bool startOnMount = true,
}) {
  final availableAt = useState<DateTime?>(null);
  final tick = useState(0);

  void startCooldown() {
    availableAt.value = DateTime.now().add(cooldown);
  }

  useEffect(() {
    if (startOnMount) {
      startCooldown();
    }
    return null;
  }, const []);

  useEffect(() {
    final timer = Timer.periodic(const Duration(seconds: 1), (_) {
      tick.value++;
    });
    return timer.cancel;
  }, const []);

  final maxSeconds = cooldown.inSeconds;

  final secondsLeft = useMemoized(() {
    final at = availableAt.value;
    if (at == null) return 0;
    return at.difference(DateTime.now()).inSeconds.clamp(0, maxSeconds);
  }, [availableAt.value, tick.value, maxSeconds]);

  final canResend = secondsLeft == 0;

  return EmailCodeResendCooldown(
    canResend: canResend,
    secondsLeft: secondsLeft,
    startCooldown: startCooldown,
  );
}
