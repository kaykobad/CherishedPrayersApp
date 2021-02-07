import 'package:cherished_prayers/data/models/models.dart';
import 'package:equatable/equatable.dart';

class ProfileAndFeedbackEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendFeedbackEvent extends ProfileAndFeedbackEvent {
  final FeedbackRequest feedbackRequest;
  final String authToken;

  SendFeedbackEvent(this.feedbackRequest, this.authToken);

  @override
  List<Object> get props => [feedbackRequest, authToken];
}

class UpdateProfilePictureEvent extends ProfileAndFeedbackEvent {
  final UpdateProfilePictureRequest updateProfilePictureRequest;
  final String authToken;

  UpdateProfilePictureEvent(this.updateProfilePictureRequest, this.authToken);

  @override
  List<Object> get props => [updateProfilePictureRequest, authToken];
}

class FetchAllCountriesEvent extends ProfileAndFeedbackEvent {
  @override
  List<Object> get props => [];
}

class FetchAllLanguagesEvent extends ProfileAndFeedbackEvent {
  @override
  List<Object> get props => [];
}

class FetchAllReligionsEvent extends ProfileAndFeedbackEvent {
  @override
  List<Object> get props => [];
}