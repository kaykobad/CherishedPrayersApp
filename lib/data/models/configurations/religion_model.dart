part of models;

@JsonSerializable()
class ReligionModel {
  final int id;
  final String religion;

  ReligionModel(this.id, this.religion);

  factory ReligionModel.fromJson(Map<String, dynamic> json) => _$ReligionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReligionModelToJson(this);
}