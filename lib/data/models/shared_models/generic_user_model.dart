part of models;

@JsonSerializable()
class GenericUserResponse {
  int id;
  String email;
  @JsonKey(name: 'first_name')
  String firstName;
  @JsonKey(name: 'last_name')
  String lastName;
  String country;
  String language;
  String religion;
  String avatar;

  GenericUserResponse(
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.country,
    this.language,
    this.religion,
    this.avatar,
  );

  factory GenericUserResponse.fromJson(Map<String, dynamic> json) => _$GenericUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GenericUserResponseToJson(this);
}