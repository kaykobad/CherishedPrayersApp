import 'package:equatable/equatable.dart';

class FeedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMyFeedEvent extends FeedEvent {
  final String authToken;

  FetchMyFeedEvent(this.authToken);

  @override
  List<Object> get props => [authToken];
}

class FetchMyPostsEvent extends FeedEvent {
  final String authToken;

  FetchMyPostsEvent(this.authToken);

  @override
  List<Object> get props => [authToken];
}