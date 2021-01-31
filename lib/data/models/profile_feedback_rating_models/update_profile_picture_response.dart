part of models;

@JsonSerializable()
class UpdateProfilePictureResponse {
  final String detail;
  final String avatar;

  UpdateProfilePictureResponse(this.detail, this.avatar);

  factory UpdateProfilePictureResponse.fromJson(Map<String, dynamic> json) => _$UpdateProfilePictureResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfilePictureResponseToJson(this);
}