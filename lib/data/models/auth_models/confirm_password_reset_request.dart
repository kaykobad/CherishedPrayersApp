part of models;

@JsonSerializable()
class ConfirmPasswordResetRequest {
  final String email;
  final String token;
  @JsonKey(name: 'new_password')
  final String newPassword;
  @JsonKey(name: 'new_password_2')
  final String newPassword2;

  ConfirmPasswordResetRequest(this.email, this.token, this.newPassword, this.newPassword2);

  factory ConfirmPasswordResetRequest.fromJson(Map<String, dynamic> json) => _$ConfirmPasswordResetRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmPasswordResetRequestToJson(this);
}