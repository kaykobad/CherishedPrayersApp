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