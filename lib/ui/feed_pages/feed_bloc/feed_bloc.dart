import 'package:bloc/bloc.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/theme/app_config.dart';
import 'package:dartz/dartz.dart';

import 'feed_event.dart';
import 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc(FeedState initialState) : super(initialState);

  @override
  Stream<FeedState> mapEventToState(FeedEvent event) async* {
    if (event is FetchMyFeedEvent) {
      yield LoadingFeedState();
      Either<DetailOnlyResponse, AllPostsResponse> _response = await apiProvider.getMyFeed(event.authToken);

      yield _response.fold(
          (failure) => ErrorState(ErrorModel(failure.detail, [""])),
          (success) => MyFeedFetchedState(success),
      );
    }
  }

}