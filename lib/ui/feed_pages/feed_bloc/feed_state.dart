import 'package:cherished_prayers/data/models/models.dart';
import 'package:equatable/equatable.dart';

class FeedState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialFeedState extends FeedState {
  @override
  List<Object> get props => [];
}

class LoadingFeedState extends FeedState {
  @override
  List<Object> get props => [];
}

class ErrorState extends FeedState {
  final ErrorModel error;

  ErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class MyFeedFetchedState extends FeedState {
  final AllPostsResponse allPosts;

  MyFeedFetchedState(this.allPosts);

  @override
  List<Object> get props => [allPosts];
}

class MyPostsFetchedState extends FeedState {
  final AllPostsResponse allPosts;

  MyPostsFetchedState(this.allPosts);

  @override
  List<Object> get props => [allPosts];
}

class PostCreatedState extends FeedState {
  final PostResponse postResponse;

  PostCreatedState(this.postResponse);

  @override
  List<Object> get props => [postResponse];
}