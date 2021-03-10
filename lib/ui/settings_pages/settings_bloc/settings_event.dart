import 'package:cherished_prayers/data/models/models.dart';
import 'package:equatable/equatable.dart';

class SettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangePasswordEvent extends SettingsEvent {
  final ChangePasswordRequest changePasswordRequest;
  final String authToken;

  ChangePasswordEvent(this.changePasswordRequest, this.authToken);

  @override
  List<Object> get props => [changePasswordRequest, authToken];
}

class ReportABugEvent extends SettingsEvent {
  final ReportBugRequest reportBugRequest;
  final String authToken;

  ReportABugEvent(this.reportBugRequest, this.authToken);

  @override
  List<Object> get props => [reportBugRequest, authToken];
}

class FetchBlockedUsersEvent extends SettingsEvent {
  final String authToken;

  FetchBlockedUsersEvent(this.authToken);

  @override
  List<Object> get props => [authToken];
}

class UnblockUserEvent extends SettingsEvent {
  final String authToken;
  final int userId;

  UnblockUserEvent(this.authToken, this.userId);

  @override
  List<Object> get props => [authToken, userId];
}
