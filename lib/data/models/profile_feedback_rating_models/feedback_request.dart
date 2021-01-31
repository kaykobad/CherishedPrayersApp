part of models;

@JsonSerializable()
class FeedbackRequest {
  final String feedback;
  final int rating;

  FeedbackRequest(this.feedback, this.rating);

  factory FeedbackRequest.fromJson(Map<String, dynamic> json) => _$FeedbackRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackRequestToJson(this);
}