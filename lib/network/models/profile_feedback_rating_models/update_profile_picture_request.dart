part of models;

@JsonSerializable()
class UpdateProfilePictureRequest {
  final String avatar;

  UpdateProfilePictureRequest(this.avatar);

  factory UpdateProfilePictureRequest.fromJson(Map<String, dynamic> json) => _$UpdateProfilePictureRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfilePictureRequestToJson(this);
}