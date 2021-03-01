part of models;

@JsonSerializable()
class SearchPeopleResponse {
  @JsonKey(name: 'search_result')
  List<SinglePeopleResponse> searchResult;

  SearchPeopleResponse(this.searchResult);

  factory SearchPeopleResponse.fromJson(Map<String, dynamic> json) => _$SearchPeopleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchPeopleResponseToJson(this);
}