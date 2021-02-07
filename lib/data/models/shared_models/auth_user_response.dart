part of models;

@JsonSerializable()
class AuthUserResponse {
  int id;
  String email;
  @JsonKey(name: 'first_name')
  String firstName;
  @JsonKey(name: 'last_name')
  String lastName;
  @JsonKey(name: 'auth_token')
  String authToken;
  @JsonKey(name: 'date_joined')
  String dateJoined;
  String country;
  String language;
  String religion;
  String avatar;

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