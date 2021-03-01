part of models;

@JsonSerializable()
class ReportBugRequest {
  @JsonKey(name: 'bug_information')
  final String bugInformation;

  ReportBugRequest(this.bugInformation);

  factory ReportBugRequest.fromJson(Map<String, dynamic> json) => _$ReportBugRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReportBugRequestToJson(this);
}