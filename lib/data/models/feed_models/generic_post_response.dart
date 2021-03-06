part of models;

@JsonSerializable()
class GenericPostResponse {
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
  @JsonKey(nullable: true)
  List<SingleCommentResponse> comments;

  GenericPostResponse(
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
    this.comments,
  );

  factory GenericPostResponse.fromJson(Map<String, dynamic> json) => _$GenericPostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GenericPostResponseToJson(this);

  GenericPostResponse.fromPostResponse(PostResponse post) {
    this.id = post.id;
    this.post = post.post;
    this.dateCreated = post.dateCreated;
    this.isEdited = post.isEdited;
    this.dateEdited = post.dateEdited;
    this.author = post.author;
    this.totalLikes = post.totalLikes;
    this.totalComments = post.totalComments;
    this.attachment = post.attachment;
    this.postPrivacy = post.postPrivacy;
  }
}