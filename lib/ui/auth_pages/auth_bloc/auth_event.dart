import 'package:cherished_prayers/data/models/models.dart';
import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final LoginRequest loginRequest;

  LoginEvent(this.loginRequest);

  @override
  List<Object> get props => [loginRequest];
}

class RegistrationEvent extends AuthEvent {
  final RegisterRequest registerRequest;

  RegistrationEvent(this.registerRequest);

  @override
  List<Object> get props => [registerRequest];
}

class VerifyEmailEvent extends AuthEvent {
  final VerifyEmailRequest verifyEmailRequest;

  VerifyEmailEvent(this.verifyEmailRequest);

  @override
  List<Object> get props => [verifyEmailRequest];
}

class ConfirmEmailVerificationEvent extends AuthEvent {
  final ConfirmVerifyEmailRequest confirmVerifyEmailRequest;

  ConfirmEmailVerificationEvent(this.confirmVerifyEmailRequest);

  @override
  List<Object> get props => [confirmVerifyEmailRequest];
}