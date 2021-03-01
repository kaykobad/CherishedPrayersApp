part of models;

@JsonSerializable()
class AllPostsResponse {
  List<PostResponse> posts;

  AllPostsResponse(this.posts);

  factory AllPostsResponse.fromJson(Map<String, dynamic> json) => _$AllPostsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllPostsResponseToJson(this);
}