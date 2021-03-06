import 'package:cherished_prayers/data/models/models.dart';
import 'package:equatable/equatable.dart';

class FriendsState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialFriendsState extends FriendsState {
  @override
  List<Object> get props => [];
}

class LoadingFriendsState extends FriendsState {
  @override
  List<Object> get props => [];
}

class AllFriendsFetchedState extends FriendsState {
  final GetAllFriendsResponse friends;

  AllFriendsFetchedState(this.friends);
  
  @override
  List<Object> get props => [friends];
}

class UnFriendSuccessState extends FriendsState {
  final int userId;

  UnFriendSuccessState(this.userId);

  @override
  List<Object> get props => [userId];
}

class CancelRequestSuccessState extends FriendsState {
  final int reqId;

  CancelRequestSuccessState(this.reqId);

  @override
  List<Object> get props => [reqId];
}

class AcceptRequestSuccessState extends FriendsState {
  final int reqId;

  AcceptRequestSuccessState(this.reqId);

  @override
  List<Object> get props => [reqId];
}

class RejectRequestSuccessState extends FriendsState {
  final int reqId;

  RejectRequestSuccessState(this.reqId);

  @override
  List<Object> get props => [reqId];
}

class ErrorState extends FriendsState {
  final ErrorModel error;

  ErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class SentRequestsFetchedState extends FriendsState {
  final GetAllSentFriendRequestResponse senRequests;

  SentRequestsFetchedState(this.senRequests);

  @override
  List<Object> get props => [senRequests];
}

class ReceivedRequestsFetchedState extends FriendsState {
  final GetAllReceivedFriendRequestResponse receivedRequests;

  ReceivedRequestsFetchedState(this.receivedRequests);

  @override
  List<Object> get props => [receivedRequests];
}

class FriendSuggestionFetchedState extends FriendsState {
  final GetFriendSuggestionsResponse friendSuggestions;

  FriendSuggestionFetchedState(this.friendSuggestions);

  @override
  List<Object> get props => [friendSuggestions];
}

class FriendRequestSentState extends FriendsState {
  final int userId;

  FriendRequestSentState(this.userId);

  @override
  List<Object> get props => [userId];
}

class SearchPeopleSuccessState extends FriendsState {
  final SearchPeopleResponse searchPeopleResponse;

  SearchPeopleSuccessState(this.searchPeopleResponse);

  @override
  List<Object> get props => [searchPeopleResponse];
}

class UserBlockedState extends FriendsState {
  final int userId;

  UserBlockedState(this.userId);

  @override
  List<Object> get props => [userId];
}