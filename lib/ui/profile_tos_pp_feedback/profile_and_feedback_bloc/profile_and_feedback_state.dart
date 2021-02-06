import 'package:cherished_prayers/data/models/models.dart';
import 'package:equatable/equatable.dart';

class ProfileAndFeedbackState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileAndFeedbackInitialState extends ProfileAndFeedbackState {
  @override
  List<Object> get props => [];
}

class FeedbackSentState extends ProfileAndFeedbackState {
  final DetailOnlyResponse feedbackResponse;

  FeedbackSentState(this.feedbackResponse);

  @override
  List<Object> get props => [feedbackResponse];
}

class FeedbackErrorState extends ProfileAndFeedbackState {
  final ErrorModel error;

  FeedbackErrorState(this.error);

  @override
  List<Object> get props => [error];
}