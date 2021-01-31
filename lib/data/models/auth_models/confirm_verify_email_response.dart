part of models;

@JsonSerializable()
class ConfirmVerifyEmailResponse {
  final String detail;

  ConfirmVerifyEmailResponse(this.detail);

  factory ConfirmVerifyEmailResponse.fromJson(Map<String, dynamic> json) => _$ConfirmVerifyEmailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmVerifyEmailResponseToJson(this);
}