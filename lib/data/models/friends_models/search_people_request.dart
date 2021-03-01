part of models;

@JsonSerializable()
class SearchPeopleRequest {
  @JsonKey(name: 'search_keyword')
  String searchKeyword;

  SearchPeopleRequest(this.searchKeyword);

  factory SearchPeopleRequest.fromJson(Map<String, dynamic> json) => _$SearchPeopleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SearchPeopleRequestToJson(this);
}