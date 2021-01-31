part of models;

@JsonSerializable()
class AuthUserResponse {
  final int id;
  final String email;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'auth_token')
  final String authToken;
  @JsonKey(name: 'date_joined')
  final String dateJoined;
  final String country;
  final String language;
  final String religion;
  final String avatar;

  AuthUserResponse(
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.authToken,
    this.dateJoined,
    this.country,
    this.language,
    this.religion,
    this.avatar,
  );

  factory AuthUserResponse.fromJson(Map<String, dynamic> json) => _$AuthUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserResponseToJson(this);
}