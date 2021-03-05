import 'package:bloc/bloc.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/theme/app_config.dart';
import 'package:dartz/dartz.dart';

import 'friends_event.dart';
import 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  FriendsBloc(FriendsState initialState) : super(initialState);

  @override
  Stream<FriendsState> mapEventToState(FriendsEvent event) async* {
    if (event is FetchAllFriendsEvent) {
      yield LoadingFriendsState();
      Either<DetailOnlyResponse, GetAllFriendsResponse> _response = await apiProvider.getAllFriends(event.authToken);

      yield _response.fold(
          (failure) => ErrorState(ErrorModel(failure.detail, [""])),
          (success) => AllFriendsFetchedState(success),
      );
    } else if (event is UnFriendEvent) {
      yield LoadingFriendsState();
      DetailOnlyResponse _response = await apiProvider.unFriend(event.authToken, event.userId);
      if (_response.detail.startsWith("Success")) yield UnFriendSuccessState(event.userId);
      else yield ErrorState(ErrorModel(_response.detail, [""]));
    } else if (event is FetchSentRequestsEvent) {
      yield LoadingFriendsState();
      Either<DetailOnlyResponse, GetAllSentFriendRequestResponse> _response = await apiProvider.getAllSentFriendRequests(event.authToken);
      yield _response.fold(
          (failure) => ErrorState(ErrorModel(failure.detail, [""])),
          (success) => SentRequestsFetchedState(success),
      );
    } else if (event is CancelFriendRequestEvent) {
      yield LoadingFriendsState();
      DetailOnlyResponse _response = await apiProvider.cancelFriendRequest(event.authToken, event.reqId);
      if (_response.detail.startsWith("Success")) yield CancelRequestSuccessState(event.reqId);
      else yield ErrorState(ErrorModel(_response.detail, [""]));
    } else if (event is FetchReceivedRequestsEvent) {
      yield LoadingFriendsState();
      Either<DetailOnlyResponse, GetAllReceivedFriendRequestResponse> _response = await apiProvider.getAllReceivedFriendRequests(event.authToken);
      yield _response.fold(
          (failure) => ErrorState(ErrorModel(failure.detail, [""])),
          (success) => ReceivedRequestsFetchedState(success),
      );
    }
  }

}