import 'dart:async';

import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/data/network/api_endpoints.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/ui/feed_pages/feed_bloc/feed_bloc.dart';
import 'package:cherished_prayers/ui/feed_pages/feed_bloc/feed_state.dart';
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
        print(_selectedIndex);
      });
    });
    _listenFeedBloc();
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
}
