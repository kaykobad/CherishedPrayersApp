part of models;

@JsonSerializable()
class ResetPasswordRequest {
  final String email;

  ResetPasswordRequest(this.email);

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) => _$ResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}