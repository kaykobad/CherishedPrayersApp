part of models;

@JsonSerializable()
class GetAllSentFriendRequestResponse {
  @JsonKey(name: 'all_sent_requests')
  List<SingleSentFriendRequestResponse> allSentRequests;

  GetAllSentFriendRequestResponse(this.allSentRequests);

  factory GetAllSentFriendRequestResponse.fromJson(Map<String, dynamic> json) => _$GetAllSentFriendRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllSentFriendRequestResponseToJson(this);
}