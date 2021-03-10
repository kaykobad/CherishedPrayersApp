import 'package:cherished_prayers/data/models/models.dart';
import 'package:equatable/equatable.dart';

class FriendsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAllFriendsEvent extends FriendsEvent {
  final String authToken;

  FetchAllFriendsEvent(this.authToken);

  @override
  List<Object> get props => [authToken];
}

class UnFriendEvent extends FriendsEvent {
  final String authToken;
  final int userId;

  UnFriendEvent(this.authToken, this.userId);

  @override
  List<Object> get props => [authToken, userId];
}

class FetchSentRequestsEvent extends FriendsEvent {
  final String authToken;

  FetchSentRequestsEvent(this.authToken);

  @override
  List<Object> get props => [authToken];
}

class FetchReceivedRequestsEvent extends FriendsEvent {
  final String authToken;

  FetchReceivedRequestsEvent(this.authToken);

  @override
  List<Object> get props => [authToken];
}

class CancelFriendRequestEvent extends FriendsEvent {
  final String authToken;
  final int reqId;

  CancelFriendRequestEvent(this.authToken, this.reqId);

  @override
  List<Object> get props => [authToken, reqId];
}

class AcceptFriendRequestEvent extends FriendsEvent {
  final String authToken;
  final int reqId;

  AcceptFriendRequestEvent(this.authToken, this.reqId);

  @override
  List<Object> get props => [authToken, reqId];
}

class RejectFriendRequestEvent extends FriendsEvent {
  final String authToken;
  final int reqId;

  RejectFriendRequestEvent(this.authToken, this.reqId);

  @override
  List<Object> get props => [authToken, reqId];
}

class FetchFriendSuggestionEvent extends FriendsEvent {
  final String authToken;

  FetchFriendSuggestionEvent(this.authToken);

  @override
  List<Object> get props => [authToken];
}

class SendFriendRequestEvent extends FriendsEvent {
  final String authToken;
  final int userId;

  SendFriendRequestEvent(this.authToken, this.userId);

  @override
  List<Object> get props => [authToken, userId];
}

class SearchPeopleEvent extends FriendsEvent {
  final SearchPeopleRequest searchPeopleRequest;
  final String authToken;

  SearchPeopleEvent(this.searchPeopleRequest, this.authToken);

  @override
  List<Object> get props => [searchPeopleRequest, authToken];
}

class BlockUserEvent extends FriendsEvent {
  final String authToken;
  final int userId;

  BlockUserEvent(this.authToken, this.userId);

  @override
  List<Object> get props => [authToken, userId];
}