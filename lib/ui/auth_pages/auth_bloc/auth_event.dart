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