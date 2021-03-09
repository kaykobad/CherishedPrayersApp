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
