part of models;

@JsonSerializable()
class PostRequest {
  String post;

  PostRequest(this.post);

  factory PostRequest.fromJson(Map<String, dynamic> json) => _$PostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PostRequestToJson(this);
}