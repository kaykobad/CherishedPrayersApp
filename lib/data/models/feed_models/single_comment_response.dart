part of models;

@JsonSerializable()
class SingleCommentResponse {
  int id;
  String comment;
  GenericUserResponse author;
  @JsonKey(name: 'post_id')
  int postId;
  @JsonKey(name: 'post_text')
  String postText;
  @JsonKey(name: 'date_created')
  String dateCreated;
  @JsonKey(name: 'is_edited')
  bool isEdited;
  @JsonKey(name: 'date_edited')
  String dateEdited;
  String attachment;
  @JsonKey(name: 'total_likes')
  int totalLikes;

  SingleCommentResponse(
    this.id,
    this.comment,
    this.author,
    this.postId,
    this.postText,
    this.dateCreated,
    this.isEdited,
    this.dateEdited,
    this.attachment,
    this.totalLikes,
  );

  factory SingleCommentResponse.fromJson(Map<String, dynamic> json) => _$SingleCommentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SingleCommentResponseToJson(this);
}