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
