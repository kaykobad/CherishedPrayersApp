import 'dart:async';

import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/data/network/api_endpoints.dart';
import 'package:cherished_prayers/helpers/navigation_helper.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/ui/feed_pages/feed_bloc/feed_event.dart';
import 'package:cherished_prayers/ui/home_pages/home_screen.dart';
import 'package:cherished_prayers/ui/shared_widgets/avatar.dart';
import 'package:cherished_prayers/ui/shared_widgets/banner_widget.dart';
import 'package:cherished_prayers/ui/shared_widgets/comment_card.dart';
import 'package:cherished_prayers/ui/shared_widgets/post_card.dart';
import 'package:cherished_prayers/ui/shared_widgets/post_comment_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'feed_bloc/feed_bloc.dart';
import 'feed_bloc/feed_state.dart';

class PostDetailsScreen extends StatefulWidget {
  final int postId;

  PostDetailsScreen({Key key, this.postId}) : super(key: key);

  @override
  _PostDetailsScreenState createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  AppDataStorage _appDataStorage;
  String _authToken;
  FeedBloc _feedBloc;
  StreamSubscription<FeedState> _feedBlocListener;
  GenericPostResponse post;
  int postId;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    _appDataStorage = RepositoryProvider.of<AppDataStorage>(context);
    _feedBloc = _appDataStorage.feedBloc;
    _authToken = _appDataStorage.userData.authToken;
    postId = widget.postId;
    isLoading = true;
    _listenFeedBloc();
    _feedBloc.add(FetchPostDetailsEvent(_authToken, postId));
  }

  @override
  void dispose() {
    _feedBlocListener?.cancel();
    super.dispose();
  }

  _listenFeedBloc() {
    _feedBlocListener = _feedBloc.listen((state) async {
      if (state is LoadingFeedState) {
        EasyLoading.show(
          status: "Loading...",
        );
      } else if (state is ErrorState) {
        await EasyLoading.dismiss();
        EasyLoading.showError(
            state.error.error + '\n' + state.error.details.join(' ')
        );
      } else if (state is PostDetailsFetchedState) {
        await EasyLoading.dismiss();
        setState(() {
          isLoading = false;
          post = state.post;
        });
      } else if (state is PostDeletedState) {
        await EasyLoading.dismiss();
        await EasyLoading.showSuccess("Post successfully deleted.");
        NavigationHelper.pushReplacement(context, HomeScreen(selectedIndex: 0));
      } else if (state is PostUpdatedState) {
        await EasyLoading.dismiss();
        EasyLoading.showSuccess("Post successfully updated.");
        post.isEdited = true;
        post.post = state.post.post;
        post.dateEdited = state.post.dateEdited;
        setState(() {});
      } else if (state is PostLikedState) {
        await EasyLoading.dismiss();
        setState(() {
          post.totalLikes += 1;
        });
        setState(() {});
      } else if (state is PostUnLikedState) {
        await EasyLoading.dismiss();
        setState(() {
          post.totalLikes -= 1;
        });
      } else if (state is CommentAddedState) {
        await EasyLoading.dismiss();
        setState(() {
          post = state.post;
        });
      } else if (state is CommentLikedState) {
        await EasyLoading.dismiss();
        setState(() {
          post.comments.forEach((element) {
            if (element.id == state.commentId) {
              element.totalLikes += 1;
            }
          });
        });
      } else if (state is CommentUnLikedState) {
        await EasyLoading.dismiss();
        setState(() {
          post.comments.forEach((element) {
            if (element.id == state.commentId) {
              element.totalLikes -= 1;
            }
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppbarWithAvatar(),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    PostCard(
                      post: post,
                      isMyPost: post.author.id == _appDataStorage.userData.id,
                      likeCallback: onLikeButtonPressed,
                      deleteCallback: onPostDeleteButtonPressed,
                      updateCallback: onPostUpdateButtonPressed,
                      isFromDetailPage: true,
                    ),
                    Divider(height: 1.0, color: ColorConstants.gray),
                    BannerWidget(text: "COMMENTS"),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => CommentCard(
                        comment: post.comments[index],
                        isMyComment: post.comments[index].author.id == _appDataStorage.userData.id,
                        likeCallback: onCommentLikeButtonPressed,
                        updateCallback: onCommentUpdateButtonPressed,
                        deleteCallback: onCommentDeleteButtonPressed,
                      ),
                      itemCount: post.comments.length,
                    ),
                    PostCommentInputWidget(url: _appDataStorage.userData.avatar == null ? null : ApiEndpoints.URL_ROOT + _appDataStorage.userData.avatar, callback: onCommentButtonPressed, isComment: true),
                  ],
                ),
              ),
      ),
    );
  }

  AppBar _getAppbarWithAvatar() {
    return AppBar(
      title: Text("Feed", style: TextStyle(color: ColorConstants.black)),
      centerTitle: true,
      backgroundColor: ColorConstants.white,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorConstants.lightPrimaryColor),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomAvatar(url: _appDataStorage.userData.avatar == null ? null : ApiEndpoints.URL_ROOT + _appDataStorage.userData.avatar, size: 36),
        ),
      ],
    );
  }

  void onLikeButtonPressed(int postId) {
    _feedBloc.add(LikePostEvent(_authToken, postId));
  }

  void onPostDeleteButtonPressed(int postId) {
    _feedBloc.add(DeletePostEvent(_authToken, postId));
  }

  void onPostUpdateButtonPressed(String text, int postId) {
    PostRequest post = PostRequest(text);
    _feedBloc.add(UpdatePostEvent(post, _authToken, postId));
  }

  void onCommentLikeButtonPressed(int postId) {
    _feedBloc.add(LikeCommentEvent(_authToken, postId));
  }

  void onCommentDeleteButtonPressed(int postId) {
    _feedBloc.add(DeletePostEvent(_authToken, postId));
  }

  void onCommentUpdateButtonPressed(String text, int postId) {
    PostRequest post = PostRequest(text);
    _feedBloc.add(UpdatePostEvent(post, _authToken, postId));
  }

  void onCommentButtonPressed(String text) {
    AddCommentRequest commentRequest = AddCommentRequest(post.id, text);
    _feedBloc.add(AddCommentEvent(_authToken, commentRequest));
  }
}
