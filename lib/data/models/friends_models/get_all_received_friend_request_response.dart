part of models;

@JsonSerializable()
class GetAllReceivedFriendRequestResponse {
  @JsonKey(name: 'all_received_requests')
  List<SingleReceivedFriendRequestResponse> allReceivedRequests;

  GetAllReceivedFriendRequestResponse(this.allReceivedRequests);

  factory GetAllReceivedFriendRequestResponse.fromJson(Map<String, dynamic> json) => _$GetAllReceivedFriendRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllReceivedFriendRequestResponseToJson(this);
}