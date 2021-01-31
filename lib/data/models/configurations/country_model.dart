part of models;

@JsonSerializable()
class CountryModel {
  final int id;
  final String country;

  CountryModel(this.id, this.country);

  factory CountryModel.fromJson(Map<String, dynamic> json) => _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}