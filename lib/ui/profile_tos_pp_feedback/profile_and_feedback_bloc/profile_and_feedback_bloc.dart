import 'package:bloc/bloc.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/theme/app_config.dart';
import 'profile_and_feedback_event.dart';
import 'profile_and_feedback_state.dart';

class ProfileAndFeedbackBloc extends Bloc<ProfileAndFeedbackEvent, ProfileAndFeedbackState> {
  ProfileAndFeedbackBloc(ProfileAndFeedbackState initialState) : super(initialState);

  @override
  Stream<ProfileAndFeedbackState> mapEventToState(ProfileAndFeedbackEvent event) async* {
    if (event is SendFeedbackEvent) {
      yield ProfileAndFeedbackLoadingState();
      DetailOnlyResponse response = await apiProvider.sendFeedback(event.feedbackRequest);

      if (response.detail.contains("Success")) {
        yield FeedbackSentState(response);
      } else {
        yield FeedbackErrorState(ErrorModel("", [response.detail]));
      }
    }
  }

}