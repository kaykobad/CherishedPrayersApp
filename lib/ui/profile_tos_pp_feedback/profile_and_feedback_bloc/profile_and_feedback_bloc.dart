import 'package:bloc/bloc.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/theme/app_config.dart';
import 'package:dartz/dartz.dart';
import 'profile_and_feedback_event.dart';
import 'profile_and_feedback_state.dart';

class ProfileAndFeedbackBloc extends Bloc<ProfileAndFeedbackEvent, ProfileAndFeedbackState> {
  ProfileAndFeedbackBloc(ProfileAndFeedbackState initialState) : super(initialState);

  @override
  Stream<ProfileAndFeedbackState> mapEventToState(ProfileAndFeedbackEvent event) async* {
    if (event is SendFeedbackEvent) {
      yield ProfileAndFeedbackLoadingState();
      DetailOnlyResponse response = await apiProvider.sendFeedback(event.feedbackRequest, event.authToken);

      if (response.detail.contains("Success")) {
        yield FeedbackSentState(response);
      } else {
        yield ProfileAndFeedbackErrorState(ErrorModel("", [response.detail]));
      }
    } else if (event is UpdateProfilePictureEvent) {
      yield ProfileAndFeedbackLoadingState();
      UpdateProfilePictureResponse response = await apiProvider.updateProfilePicture(event.updateProfilePictureRequest, event.authToken);

      if (response.detail.contains("Success")) {
        yield ProfilePictureUpdatedState(response);
      } else {
        yield ProfileAndFeedbackErrorState(ErrorModel("", [response.detail]));
      }
    } else if (event is FetchAllCountriesEvent) {
      yield ProfileAndFeedbackLoadingState();
      Either<ErrorModel, AllCountriesResponse> _response = await apiProvider.getAllCountries();

      yield _response.fold(
        (failure) => ProfileAndFeedbackErrorState(failure),
        (success) => AllCountriesFetchedState(success),
      );
    } else if (event is FetchAllLanguagesEvent) {
      yield ProfileAndFeedbackLoadingState();
      Either<ErrorModel, AllLanguagesResponse> _response = await apiProvider.getAllLanguages();

      yield _response.fold(
        (failure) => ProfileAndFeedbackErrorState(failure),
        (success) => AllLanguagesFetchedState(success),
      );
    } else if (event is FetchAllReligionsEvent) {
      yield ProfileAndFeedbackLoadingState();
      Either<ErrorModel, AllReligionsResponse> _response = await apiProvider.getAllReligions();

      yield _response.fold(
        (failure) => ProfileAndFeedbackErrorState(failure),
        (success) => AllReligionsFetchedState(success),
      );
    }
  }

}