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

class ProfileAndFeedbackLoadingState extends ProfileAndFeedbackState {
  @override
  List<Object> get props => [];
}

class FeedbackSentState extends ProfileAndFeedbackState {
  final DetailOnlyResponse feedbackResponse;

  FeedbackSentState(this.feedbackResponse);

  @override
  List<Object> get props => [feedbackResponse];
}

class ProfileAndFeedbackErrorState extends ProfileAndFeedbackState {
  final ErrorModel error;

  ProfileAndFeedbackErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class ProfilePictureUpdatedState extends ProfileAndFeedbackState {
  final UpdateProfilePictureResponse updateProfilePictureResponse;

  ProfilePictureUpdatedState(this.updateProfilePictureResponse);

  @override
  List<Object> get props => [updateProfilePictureResponse];
}

class AllCountriesFetchedState extends ProfileAndFeedbackState {
  final AllCountriesResponse allCountriesResponse;

  AllCountriesFetchedState(this.allCountriesResponse);

  @override
  List<Object> get props => [allCountriesResponse];
}

class AllLanguagesFetchedState extends ProfileAndFeedbackState {
  final AllLanguagesResponse allLanguagesResponse;

  AllLanguagesFetchedState(this.allLanguagesResponse);

  @override
  List<Object> get props => [allLanguagesResponse];
}

class AllReligionsFetchedState extends ProfileAndFeedbackState {
  final AllReligionsResponse allReligionsResponse;

  AllReligionsFetchedState(this.allReligionsResponse);

  @override
  List<Object> get props => [allReligionsResponse];
}