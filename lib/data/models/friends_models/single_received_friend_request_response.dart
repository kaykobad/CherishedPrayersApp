part of models;

@JsonSerializable()
class SingleReceivedFriendRequestResponse {
  int id;
  GenericUserResponse sender;
  @JsonKey(name: 'request_send_date')
  String requestSendDate;

  SingleReceivedFriendRequestResponse(
    this.id,
    this.sender,
    this.requestSendDate,
  );

  factory SingleReceivedFriendRequestResponse.fromJson(Map<String, dynamic> json) => _$SingleReceivedFriendRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SingleReceivedFriendRequestResponseToJson(this);
}