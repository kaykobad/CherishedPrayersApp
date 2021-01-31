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

class ErrorState extends AuthState {
  final ErrorModel error;

  ErrorState(this.error);

  @override
  List<Object> get props => [error];
}