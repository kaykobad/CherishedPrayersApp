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
    } else if (event is AcceptFriendRequestEvent) {
      yield LoadingFriendsState();
      DetailOnlyResponse _response = await apiProvider.acceptFriendRequest(event.authToken, event.reqId);
      if (_response.detail.startsWith("Success")) yield AcceptRequestSuccessState(event.reqId);
      else yield ErrorState(ErrorModel(_response.detail, [""]));
    } else if (event is RejectFriendRequestEvent) {
      yield LoadingFriendsState();
      DetailOnlyResponse _response = await apiProvider.rejectFriendRequest(event.authToken, event.reqId);
      if (_response.detail.startsWith("Success")) yield RejectRequestSuccessState(event.reqId);
      else yield ErrorState(ErrorModel(_response.detail, [""]));
    } else if (event is FetchFriendSuggestionEvent) {
      yield LoadingFriendsState();
      Either<DetailOnlyResponse, GetFriendSuggestionsResponse> _response = await apiProvider.getFriendSuggestions(event.authToken);
      yield _response.fold(
          (failure) => ErrorState(ErrorModel(failure.detail, [""])),
          (success) => FriendSuggestionFetchedState(success),
      );
    } else if (event is SendFriendRequestEvent) {
      yield LoadingFriendsState();
      DetailOnlyResponse _response = await apiProvider.sendFriendRequest(event.authToken, event.userId);
      if (_response.detail.startsWith("Success")) yield FriendRequestSentState(event.userId);
      else yield ErrorState(ErrorModel(_response.detail, [""]));
    } else if (event is SearchPeopleEvent) {
      yield LoadingFriendsState();
      Either<DetailOnlyResponse, SearchPeopleResponse> _response = await apiProvider.searchPeople(event.searchPeopleRequest, event.authToken);
      yield _response.fold(
          (failure) => ErrorState(ErrorModel(failure.detail, [""])),
          (success) => SearchPeopleSuccessState(success),
      );
    } else if (event is BlockUserEvent) {
      yield LoadingFriendsState();
      DetailOnlyResponse _response = await apiProvider.blockUser(event.authToken, event.userId);
      if (_response.detail.startsWith("Success")) yield UserBlockedState(event.userId);
      else yield ErrorState(ErrorModel(_response.detail, [""]));
    }
  }

}