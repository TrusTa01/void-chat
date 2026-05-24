import 'package:void_chat/features/auth/register/domain/failures/register_failure.dart';
import 'package:void_chat/features/auth/shared/domain/entities/user_entity.dart';

sealed class RegisterState {
  const RegisterState();
}

final class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

final class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

final class RegisterStarted extends RegisterState {
  final String registrationId;
  const RegisterStarted(this.registrationId);
}

final class RegisterEmailVerified extends RegisterState {
  const RegisterEmailVerified();
}

final class RegisterCodeResent extends RegisterState {
  const RegisterCodeResent();
}

final class RegisterCompleted extends RegisterState {
  final UserEntity user;
  const RegisterCompleted(this.user);
}

final class RegisterError extends RegisterState {
  final RegisterFailure failure;
  const RegisterError(this.failure);
}
