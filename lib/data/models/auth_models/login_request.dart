part of models;

@JsonSerializable()
class LoginRequest {
  final String email;
  final String password;

  LoginRequest(this.email, this.password);

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}