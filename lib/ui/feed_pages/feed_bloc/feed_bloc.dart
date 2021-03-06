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
    } else if (event is FetchMyPostsEvent) {
      yield LoadingFeedState();
      Either<DetailOnlyResponse, AllPostsResponse> _response = await apiProvider.getAllMyPosts(event.authToken);

      yield _response.fold(
          (failure) => ErrorState(ErrorModel(failure.detail, [""])),
          (success) => MyPostsFetchedState(success),
      );
    } else if (event is CreatePostEvent) {
      yield LoadingFeedState();
      Either<DetailOnlyResponse, PostResponse> _response = await apiProvider.createPost(event.post, event.authToken);

      yield _response.fold(
          (failure) => ErrorState(ErrorModel(failure.detail, [""])),
          (success) => PostCreatedState(success),
      );
    } else if (event is LikePostEvent) {
      yield LoadingFeedState();
      DetailOnlyResponse _response = await apiProvider.likePost(event.authToken, event.postId);
      if (_response.detail.startsWith("Success")) {
        if (_response.detail.contains("unlike")) yield PostUnLikedState(event.postId);
        else yield PostLikedState(event.postId);
      }
      else yield ErrorState(ErrorModel(_response.detail, [""]));
    } else if (event is DeletePostEvent) {
      yield LoadingFeedState();
      DetailOnlyResponse _response = await apiProvider.deletePost(event.authToken, event.postId);
      if (_response.detail.startsWith("Success")) yield PostDeletedState(event.postId);
      else yield ErrorState(ErrorModel(_response.detail, [""]));
    } else if (event is UpdatePostEvent) {
      yield LoadingFeedState();
      Either<DetailOnlyResponse, GenericPostResponse> _response = await apiProvider.updatePost(event.post, event.authToken, event.postId);

      yield _response.fold(
          (failure) => ErrorState(ErrorModel(failure.detail, [""])),
          (success) => PostUpdatedState(success),
      );
    } else if (event is FetchPostDetailsEvent) {
      yield LoadingFeedState();
      Either<DetailOnlyResponse, GenericPostResponse> _response = await apiProvider.getPostDetails(event.authToken, event.postId);

      yield _response.fold(
          (failure) => ErrorState(ErrorModel(failure.detail, [""])),
          (success) => PostDetailsFetchedState(success),
      );
    } else if (event is AddCommentEvent) {
      yield LoadingFeedState();
      Either<DetailOnlyResponse, GenericPostResponse> _response = await apiProvider.addComment(event.addCommentRequest, event.authToken);

      yield _response.fold(
          (failure) => ErrorState(ErrorModel(failure.detail, [""])),
          (success) => CommentAddedState(success),
      );
    } else if (event is DeleteCommentEvent) {
      yield LoadingFeedState();
      Either<DetailOnlyResponse, GenericPostResponse> _response = await apiProvider.deleteComment(event.authToken, event.commentId);

      yield _response.fold(
          (failure) => ErrorState(ErrorModel(failure.detail, [""])),
          (success) => CommentDeletedState(success),
      );
    } else if (event is UpdateCommentEvent) {
      yield LoadingFeedState();
      Either<DetailOnlyResponse, GenericPostResponse> _response = await apiProvider.updateComment(event.updateCommentRequest, event.authToken, event.commentId);

      yield _response.fold(
          (failure) => ErrorState(ErrorModel(failure.detail, [""])),
          (success) => CommentUpdatedState(success),
      );
    } else if (event is LikeCommentEvent) {
      yield LoadingFeedState();
      DetailOnlyResponse _response = await apiProvider.likeComment(event.authToken, event.commentId);
      if (_response.detail.startsWith("Success")) {
        if (_response.detail.contains("unlike")) yield CommentUnLikedState(event.commentId);
        else yield CommentLikedState(event.commentId);
      }
      else yield ErrorState(ErrorModel(_response.detail, [""]));
    }
  }

}