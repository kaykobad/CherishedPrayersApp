import 'package:cherished_prayers/data/models/models.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialAuthState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoginSuccessfulState extends AuthState {
  final AuthUserResponse authUserData;

  LoginSuccessfulState(this.authUserData);

  @override
  List<Object> get props => [authUserData];
}

class RegistrationSuccessfulState extends AuthState {
  final AuthUserResponse authUserData;

  RegistrationSuccessfulState(this.authUserData);

  @override
  List<Object> get props => [authUserData];
}

class EmailSentState extends AuthState {
  final EmailVerificationResponse emailVerificationResponse;

  EmailSentState(this.emailVerificationResponse);

  @override
  List<Object> get props => [emailVerificationResponse];
}

class PasswordResetInitiatedState extends AuthState {
  final DetailOnlyResponse response;

  PasswordResetInitiatedState(this.response);

  @override
  List<Object> get props => [response];
}

class PasswordResetConfirmedState extends AuthState {
  final DetailOnlyResponse passwordResetConfirmed;

  PasswordResetConfirmedState(this.passwordResetConfirmed);

  @override
  List<Object> get props => [passwordResetConfirmed];
}

class EmailVerifiedState extends AuthState {
  final DetailOnlyResponse confirmVerifyEmailResponse;

  EmailVerifiedState(this.confirmVerifyEmailResponse);

  @override
  List<Object> get props => [confirmVerifyEmailResponse];
}

class ErrorState extends AuthState {
  final ErrorModel error;

  ErrorState(this.error);

  @override
  List<Object> get props => [error];
}