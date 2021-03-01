part of models;

@JsonSerializable()
class PostResponse {
  int id;
  String post;
  @JsonKey(name: 'date_created')
  String dateCreated;
  @JsonKey(name: 'is_edited')
  bool isEdited;
  @JsonKey(name: 'date_edited')
  String dateEdited;
  GenericUserResponse author;
  @JsonKey(name: 'total_likes')
  int totalLikes;
  @JsonKey(name: 'total_comments')
  int totalComments;
  String attachment;
  @JsonKey(name: 'post_privacy')
  String postPrivacy;

  PostResponse(
    this.id,
    this.post,
    this.dateCreated,
    this.isEdited,
    this.dateEdited,
    this.author,
    this.totalLikes,
    this.totalComments,
    this.attachment,
    this.postPrivacy,
  );

  factory PostResponse.fromJson(Map<String, dynamic> json) => _$PostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}