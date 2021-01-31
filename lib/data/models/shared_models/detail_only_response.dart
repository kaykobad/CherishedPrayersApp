part of models;

@JsonSerializable()
class DetailOnlyResponse {
  final String detail;

  DetailOnlyResponse(this.detail);

  factory DetailOnlyResponse.fromJson(Map<String, dynamic> json) => _$DetailOnlyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailOnlyResponseToJson(this);
}