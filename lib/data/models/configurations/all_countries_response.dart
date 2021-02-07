part of models;

@JsonSerializable()
class AllCountriesResponse {
  final List<CountryModel> countries;

  AllCountriesResponse(this.countries);

  factory AllCountriesResponse.fromJson(Map<String, dynamic> json) => _$AllCountriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllCountriesResponseToJson(this);
}