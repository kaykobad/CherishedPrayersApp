part of models;

@JsonSerializable()
class ErrorVerificationResponse {
  final String success;

  ErrorVerificationResponse(this.success);

  factory ErrorVerificationResponse.fromJson(Map<String, dynamic> json) => _$ErrorVerificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorVerificationResponseToJson(this);
}