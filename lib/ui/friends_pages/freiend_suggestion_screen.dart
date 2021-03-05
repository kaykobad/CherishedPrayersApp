import 'dart:async';

import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/data/network/api_endpoints.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/ui/friends_pages/firends_bloc/friends_bloc.dart';
import 'package:cherished_prayers/ui/shared_widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'firends_bloc/friends_state.dart';

class FriendsScreen extends StatefulWidget {
  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> with SingleTickerProviderStateMixin {
  List<String> _titles = ["Find Friends", "Sent Requests", "Friend Requests"];
  int _selectedIndex = 0;
  TabController _tabController;
  AppDataStorage _appDataStorage;
  FriendsBloc _friendsBloc;
  int _myId;
  StreamSubscription<FriendsState> _friendsBlocListener;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _appDataStorage = RepositoryProvider.of<AppDataStorage>(context);
    _friendsBloc = _appDataStorage.friendsBloc;
    _myId = _appDataStorage.userData.id;
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
        print(_selectedIndex);
      });
    });
    _listenFriendsBloc();
  }

  _listenFriendsBloc() {
    _friendsBlocListener = _friendsBloc.listen((state) async {
      if (state is LoadingFriendsState) {
        EasyLoading.show(
          status: "Loading...",
        );
      } else if (state is ErrorState) {
        await EasyLoading.dismiss();
        EasyLoading.showError(
            state.error.error + '\n' + state.error.details.join(' ')
        );
      } else if (state is AllFriendsFetchedState) {
        await EasyLoading.dismiss();
        setState(() {

        });
      } else if (state is UnFriendSuccessState) {
        await EasyLoading.dismiss();
        EasyLoading.showSuccess("Unfriend successful");
      }
    });
  }

  @override
  void dispose() {
    _friendsBlocListener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [

              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      title: Text(_titles[_selectedIndex], style: TextStyle(color: ColorConstants.black)),
      centerTitle: true,
      backgroundColor: ColorConstants.white,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorConstants.lightPrimaryColor),
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: ColorConstants.lightPrimaryColor,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
        tabs: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("Suggestions", style: TextStyle(color: ColorConstants.black)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("Sent", style: TextStyle(color: ColorConstants.black)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("Received", style: TextStyle(color: ColorConstants.black)),
          ),
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomAvatar(url: _appDataStorage.userData.avatar == null ? null : ApiEndpoints.URL_ROOT + _appDataStorage.userData.avatar, size: 36),
        ),
      ],
    );
  }
}