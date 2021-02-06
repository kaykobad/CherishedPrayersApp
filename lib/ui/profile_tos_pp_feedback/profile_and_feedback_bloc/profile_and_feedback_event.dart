import 'package:cherished_prayers/data/models/models.dart';
import 'package:equatable/equatable.dart';

class ProfileAndFeedbackEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendFeedbackEvent extends ProfileAndFeedbackEvent {
  final FeedbackRequest feedbackRequest;

  SendFeedbackEvent(this.feedbackRequest);

  @override
  List<Object> get props => [feedbackRequest];
}