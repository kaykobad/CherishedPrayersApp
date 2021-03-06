import 'package:cherished_prayers/data/models/models.dart';
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

class CreatePostEvent extends FeedEvent {
  final String authToken;
  final PostRequest post;

  CreatePostEvent(this.authToken, this.post);

  @override
  List<Object> get props => [authToken, post];
}

class LikePostEvent extends FeedEvent {
  final String authToken;
  final int postId;

  LikePostEvent(this.authToken, this.postId);

  @override
  List<Object> get props => [authToken, postId];
}

class DeletePostEvent extends FeedEvent {
  final String authToken;
  final int postId;

  DeletePostEvent(this.authToken, this.postId);

  @override
  List<Object> get props => [authToken, postId];
}

class UpdatePostEvent extends FeedEvent {
  final PostRequest post;
  final String authToken;
  final int postId;

  UpdatePostEvent(this.post, this.authToken, this.postId);

  @override
  List<Object> get props => [post, authToken, postId];
}

class FetchPostDetailsEvent extends FeedEvent {
  final String authToken;
  final int postId;

  FetchPostDetailsEvent(this.authToken, this.postId);

  @override
  List<Object> get props => [authToken, postId];
}

class LikeCommentEvent extends FeedEvent {
  final String authToken;
  final int commentId;

  LikeCommentEvent(this.authToken, this.commentId);

  @override
  List<Object> get props => [authToken, commentId];
}

class AddCommentEvent extends FeedEvent {
  final String authToken;
  final AddCommentRequest addCommentRequest;

  AddCommentEvent(this.authToken, this.addCommentRequest);

  @override
  List<Object> get props => [authToken, addCommentRequest];
}

class DeleteCommentEvent extends FeedEvent {
  final String authToken;
  final int commentId;

  DeleteCommentEvent(this.authToken, this.commentId);

  @override
  List<Object> get props => [authToken, commentId];
}

class UpdateCommentEvent extends FeedEvent {
  final UpdateCommentRequest updateCommentRequest;
  final String authToken;
  final int commentId;

  UpdateCommentEvent(this.updateCommentRequest, this.authToken, this.commentId);

  @override
  List<Object> get props => [updateCommentRequest, authToken, commentId];
}