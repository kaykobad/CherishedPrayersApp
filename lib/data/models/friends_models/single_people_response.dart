part of models;

@JsonSerializable()
class SinglePeopleResponse {
  GenericUserResponse user;
  @JsonKey(name: 'is_friend')
  bool isFriend;

  SinglePeopleResponse(this.user, this.isFriend);

  factory SinglePeopleResponse.fromJson(Map<String, dynamic> json) => _$SinglePeopleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SinglePeopleResponseToJson(this);
}