part of models;

@JsonSerializable()
class AddCommentRequest {
  @JsonKey(name: 'post_id')
  int postId;
  String comment;

  AddCommentRequest(this.postId, this.comment);

  factory AddCommentRequest.fromJson(Map<String, dynamic> json) => _$AddCommentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddCommentRequestToJson(this);
}