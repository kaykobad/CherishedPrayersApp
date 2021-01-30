part of models;

@JsonSerializable()
class UpdateValueRequest {
  final String value;

  UpdateValueRequest(this.value);

  factory UpdateValueRequest.fromJson(Map<String, dynamic> json) => _$UpdateValueRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateValueRequestToJson(this);
}