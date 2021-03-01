part of models;

@JsonSerializable()
class SingleFriendResponse {
  GenericUserResponse friend;
  @JsonKey(name: 'friend_since')
  String friendSince;

  SingleFriendResponse(
    this.friend,
    this.friendSince,
  );

  factory SingleFriendResponse.fromJson(Map<String, dynamic> json) => _$SingleFriendResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SingleFriendResponseToJson(this);
}