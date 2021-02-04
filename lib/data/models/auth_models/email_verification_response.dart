part of models;

@JsonSerializable()
class EmailVerificationResponse {
  final String success;

  EmailVerificationResponse(this.success);

  factory EmailVerificationResponse.fromJson(Map<String, dynamic> json) => _$EmailVerificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EmailVerificationResponseToJson(this);
}