part of models;

@JsonSerializable()
class ErrorModel {
  final String error;
  final List<String> details;

  ErrorModel(this.error, this.details);

  factory ErrorModel.fromJson(Map<String, dynamic> json) => _$ErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);
}