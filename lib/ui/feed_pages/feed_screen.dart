import 'dart:async';

import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/data/network/api_endpoints.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/ui/feed_pages/feed_bloc/feed_bloc.dart';
import 'package:cherished_prayers/ui/feed_pages/feed_bloc/feed_event.dart';
import 'package:cherished_prayers/ui/feed_pages/feed_bloc/feed_state.dart';
import 'package:cherished_prayers/ui/shared_widgets/banner_widget.dart';
import 'package:cherished_prayers/ui/shared_widgets/post_card.dart';
import 'package:cherished_prayers/ui/shared_widgets/post_comment_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with SingleTickerProviderStateMixin {
  AppDataStorage _appDataStorage;
  TabController _tabController;
  int _selectedIndex = 0;
  String _authToken;
  FeedBloc _feedBloc;
  StreamSubscription<FeedState> _feedBlocListener;
  List<PostResponse> _allFeedPosts = [];
  List<PostResponse> _allMyPosts = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _appDataStorage = RepositoryProvider.of<AppDataStorage>(context);
    _feedBloc = _appDataStorage.feedBloc;
    _authToken = _appDataStorage.userData.authToken;
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
      if(_selectedIndex == 0) _feedBloc.add(FetchMyFeedEvent(_authToken));
      else _feedBloc.add(FetchMyPostsEvent(_authToken));
    });
    _listenFeedBloc();
    _feedBloc.add(FetchMyFeedEvent(_authToken));
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
      } else if (state is MyFeedFetchedState) {
        await EasyLoading.dismiss();
        setState(() {
          _allFeedPosts = state.allPosts.posts;
        });
      } else if (state is MyPostsFetchedState) {
        await EasyLoading.dismiss();
        setState(() {
          _allMyPosts = state.allPosts.posts;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              PostCommentInputWidget(url: _appDataStorage.userData.avatar == null ? null : ApiEndpoints.URL_ROOT + _appDataStorage.userData.avatar, callback: onPostButtonPressed),
              SizedBox(height: 10.0),
              _getTabBar(),
              Divider(height: 1.0, color: ColorConstants.gray),
              BannerWidget(text: "POSTS"),
              _getBody(),
            ],
          ),
        ),
      ),
    );
  }

  TabBar _getTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: ColorConstants.lightPrimaryColor,
      indicatorPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
      tabs: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text("Following", style: TextStyle(color: ColorConstants.black)),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text("You", style: TextStyle(color: ColorConstants.black)),
        ),
      ],
    );
  }

  void onPostButtonPressed(String text) {
    print(text);
  }

  _getBody() {
    List<PostResponse> _showAblePosts = [];
    if (_selectedIndex == 0) _showAblePosts = _allFeedPosts;
    else _showAblePosts = _allMyPosts;

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => PostCard(post: _showAblePosts[index], isMyPost: _selectedIndex==1,),
      itemCount: _showAblePosts.length,
    );
  }
}
