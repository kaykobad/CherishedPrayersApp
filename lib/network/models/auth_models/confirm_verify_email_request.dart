part of models;

@JsonSerializable()
class ConfirmVerifyEmailRequest {
  final String email;
  @JsonKey(name: 'verification_code')
  final String verificationCode;

  ConfirmVerifyEmailRequest(this.email, this.verificationCode);

  factory ConfirmVerifyEmailRequest.fromJson(Map<String, dynamic> json) => _$ConfirmVerifyEmailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmVerifyEmailRequestToJson(this);
}