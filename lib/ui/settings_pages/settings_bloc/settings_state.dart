import 'package:cherished_prayers/data/models/models.dart';
import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialSettingsState extends SettingsState {
  @override
  List<Object> get props => [];
}

class LoadingSettingsState extends SettingsState {
  @override
  List<Object> get props => [];
}

class ErrorState extends SettingsState {
  final ErrorModel error;

  ErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class PasswordChangedState extends SettingsState {
  @override
  List<Object> get props => [];
}

class BugReportedState extends SettingsState {
  @override
  List<Object> get props => [];
}

