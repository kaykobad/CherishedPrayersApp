part of models;

@JsonSerializable()
class LanguageModel {
  final int id;
  final String language;

  LanguageModel(this.id, this.language);

  factory LanguageModel.fromJson(Map<String, dynamic> json) => _$LanguageModelFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageModelToJson(this);
}