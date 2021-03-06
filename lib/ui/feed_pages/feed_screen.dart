import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/data/network/api_endpoints.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/ui/shared_widgets/post_comment_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with SingleTickerProviderStateMixin {
  AppDataStorage _appDataStorage;
  TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _appDataStorage = RepositoryProvider.of<AppDataStorage>(context);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
        print(_selectedIndex);
      });
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
