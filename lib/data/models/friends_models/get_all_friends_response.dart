part of models;

@JsonSerializable()
class GetAllFriendsResponse {
  @JsonKey(name: 'all_friends')
  List<SingleFriendResponse> allFriends;

  GetAllFriendsResponse(this.allFriends);

  factory GetAllFriendsResponse.fromJson(Map<String, dynamic> json) => _$GetAllFriendsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllFriendsResponseToJson(this);
}