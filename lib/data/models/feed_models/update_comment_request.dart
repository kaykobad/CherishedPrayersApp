part of models;

@JsonSerializable()
class UpdateCommentRequest {
  String comment;

  UpdateCommentRequest(this.comment);

  factory UpdateCommentRequest.fromJson(Map<String, dynamic> json) => _$UpdateCommentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCommentRequestToJson(this);
}