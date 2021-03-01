part of models;

@JsonSerializable()
class GetFriendSuggestionsResponse {
  List<GenericUserResponse> suggestions;

  GetFriendSuggestionsResponse(this.suggestions);

  factory GetFriendSuggestionsResponse.fromJson(Map<String, dynamic> json) => _$GetFriendSuggestionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetFriendSuggestionsResponseToJson(this);
}