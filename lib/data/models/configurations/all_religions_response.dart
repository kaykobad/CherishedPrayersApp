part of models;

@JsonSerializable()
class AllReligionsResponse {
  final List<ReligionModel> religions;

  AllReligionsResponse(this.religions);

  factory AllReligionsResponse.fromJson(Map<String, dynamic> json) => _$AllReligionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllReligionsResponseToJson(this);
}