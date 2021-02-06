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

class ResetPasswordEvent extends AuthEvent {
  final ResetPasswordRequest resetPasswordRequest;

  ResetPasswordEvent(this.resetPasswordRequest);

  @override
  List<Object> get props => [resetPasswordRequest];
}

class ConfirmResetPasswordEvent extends AuthEvent {
  final ConfirmPasswordResetRequest confirmPasswordResetRequest;

  ConfirmResetPasswordEvent(this.confirmPasswordResetRequest);

  @override
  List<Object> get props => [confirmPasswordResetRequest];
}