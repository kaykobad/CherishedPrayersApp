part of models;

@JsonSerializable()
class AllLanguagesResponse {
  final List<LanguageModel> languages;

  AllLanguagesResponse(this.languages);

  factory AllLanguagesResponse.fromJson(Map<String, dynamic> json) => _$AllLanguagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllLanguagesResponseToJson(this);
}