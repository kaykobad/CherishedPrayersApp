part of models;

@JsonSerializable()
class GetAllBlockedUsersResponse {
  @JsonKey(name: 'blocked_users')
  List<GenericUserResponse> blockedUsers;

  GetAllBlockedUsersResponse(this.blockedUsers);

  factory GetAllBlockedUsersResponse.fromJson(Map<String, dynamic> json) => _$GetAllBlockedUsersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllBlockedUsersResponseToJson(this);
}