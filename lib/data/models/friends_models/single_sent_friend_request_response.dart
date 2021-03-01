part of models;

@JsonSerializable()
class SingleSentFriendRequestResponse {
  int id;
  GenericUserResponse receiver;
  @JsonKey(name: 'request_send_date')
  String requestSendDate;

  SingleSentFriendRequestResponse(
    this.id,
    this.receiver,
    this.requestSendDate,
  );

  factory SingleSentFriendRequestResponse.fromJson(Map<String, dynamic> json) => _$SingleSentFriendRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SingleSentFriendRequestResponseToJson(this);
}