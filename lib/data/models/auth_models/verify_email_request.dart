part of models;

@JsonSerializable()
class VerifyEmailRequest {
  final String email;

  VerifyEmailRequest(this.email);

  factory VerifyEmailRequest.fromJson(Map<String, dynamic> json) => _$VerifyEmailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyEmailRequestToJson(this);
}