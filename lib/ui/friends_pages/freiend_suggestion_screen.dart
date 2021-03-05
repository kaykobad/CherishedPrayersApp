import 'dart:async';

import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/data/network/api_endpoints.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/ui/friends_pages/friends_bloc/friends_event.dart';
import 'package:cherished_prayers/ui/shared_widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'friends_bloc/friends_bloc.dart';
import 'friends_bloc/friends_state.dart';

class FriendsScreen extends StatefulWidget {
  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> with SingleTickerProviderStateMixin {
  List<String> _titles = ["Find Friends", "Sent Requests", "Friend Requests"];
  List<String> _searchHints = ["Search on cherished prayers", "Search Requests", "Search for invitations"];
  int _selectedIndex = 0;
  TabController _tabController;
  AppDataStorage _appDataStorage;
  FriendsBloc _friendsBloc;
  int _myId;
  String _authToken;
  StreamSubscription<FriendsState> _friendsBlocListener;
  List<SingleSentFriendRequestResponse> _sentRequests = [];
  List<SingleReceivedFriendRequestResponse> _receivedRequests = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _appDataStorage = RepositoryProvider.of<AppDataStorage>(context);
    _friendsBloc = _appDataStorage.friendsBloc;
    _myId = _appDataStorage.userData.id;
    _authToken = _appDataStorage.userData.authToken;
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
        print(_selectedIndex);
      });

      if (_selectedIndex == 1) _friendsBloc.add(FetchSentRequestsEvent(_authToken));
      else if (_selectedIndex == 2) _friendsBloc.add(FetchReceivedRequestsEvent(_authToken));
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
      } else if (state is SentRequestsFetchedState) {
        await EasyLoading.dismiss();
        setState(() {
          _sentRequests = state.senRequests.allSentRequests;
        });
      } else if (state is CancelRequestSuccessState) {
        await EasyLoading.dismiss();
        EasyLoading.showSuccess("Friend request cancelled.");
        setState(() {
          _sentRequests.removeWhere((element) => element.id == state.reqId);
        });
      } else if (state is ReceivedRequestsFetchedState) {
        await EasyLoading.dismiss();
        setState(() {
          _receivedRequests = state.receivedRequests.allReceivedRequests;
        });
      } else if (state is AcceptRequestSuccessState) {
        await EasyLoading.dismiss();
        EasyLoading.showSuccess("Friend request accepted. Person added to your friend list.");
        setState(() {
          _receivedRequests.removeWhere((element) => element.id == state.reqId);
        });
      } else if (state is RejectRequestSuccessState) {
        await EasyLoading.dismiss();
        EasyLoading.showSuccess("Friend request rejected.");
        setState(() {
          _receivedRequests.removeWhere((element) => element.id == state.reqId);
        });
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
            child: _getBody(),
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

  Widget _getBody() {
    if (_selectedIndex == 0) return _getSuggestionsPage();
    else if (_selectedIndex == 1) return _getSentRequestPage();
    return _getReceivedRequestPage();
  }

  Widget _getSuggestionsPage() {
    return Column(
      children: [
        Text("Hello 1"),
      ],
    );
  }

  Widget _getSentRequestPage() {
    return Column(
      children: [
        _getSearchWidget(),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Sent Friend Requests",
            style: TextStyle(
              color: ColorConstants.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Divider(color: Colors.grey[400], height: 1.0),
        SizedBox(height: 12.0),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) => buildItem(_sentRequests[index].receiver),
          itemCount: _sentRequests.length,
        ),
      ],
    );
  }

  Widget _getReceivedRequestPage() {
    return Column(
      children: [
        _getSearchWidget(),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Invitations List",
            style: TextStyle(
              color: ColorConstants.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Divider(color: Colors.grey[400], height: 1.0),
        SizedBox(height: 12.0),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) => buildItem(_receivedRequests[index].sender),
          itemCount: _receivedRequests.length,
        ),
      ],
    );
  }

  Widget _getSearchWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          cursorColor: ColorConstants.lightPrimaryColor,
          autofocus: false,
          style: DefaultTextStyle.of(context).style.copyWith(
            fontStyle: FontStyle.normal,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, size: 28),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            hintText: _searchHints[_selectedIndex],
            isDense: true,
            fillColor: ColorConstants.gray,
          ),
        ),
        suggestionsCallback: (pattern) async {
          if (_selectedIndex == 1) return _sentRequests.where((element) => element.receiver.firstName.toLowerCase().contains(pattern.toLowerCase()));
          else if (_selectedIndex == 2) return _receivedRequests.where((element) => element.sender.firstName.toLowerCase().contains(pattern.toLowerCase()));
          return _sentRequests;
        },
        itemBuilder: (context, suggestion) {
          if (_selectedIndex == 1) return buildItem(suggestion.receiver);
          return buildItem(suggestion.sender);
        },
        onSuggestionSelected: (suggestion) {},
      ),
    );
  }

  Widget buildItem(user) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAvatar(url: (user.avatar == "" || user.avatar == null) ? null : ApiEndpoints.URL_ROOT + user.avatar, size: 60.0),
            Flexible(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        user.firstName,
                        style: TextStyle(
                          color: ColorConstants.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                    ),
                    Container(
                      child: Text(
                        user.religion,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: ColorConstants.gray),
                      ),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    )
                  ],
                ),
                margin: EdgeInsets.only(left: 10.0),
              ),
            ),
            SizedBox(width: 8.0),
            _getActions(user),
          ],
        ),
        SizedBox(height: 12.0),
        Divider(color: Colors.grey[400], height: 1.0),
        SizedBox(height: 12.0),
      ],
    );
  }

  Widget _getActions(user) {
    if (_selectedIndex == 1) {
      return _getButton(
        () {
          int _reqId = _sentRequests.where((element) => element.receiver.id == user.id).first.id;
          _friendsBloc.add(CancelFriendRequestEvent(_authToken, _reqId));
        },
        "Cancel",);
    }
    else if (_selectedIndex == 2) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getButton(
            () {
              int _reqId = _receivedRequests.where((element) => element.sender.id == user.id).first.id;
              _friendsBloc.add(AcceptFriendRequestEvent(_authToken, _reqId));
            },
            "Accept",
            isFilled: true,
          ),
          SizedBox(width: 6.0),
          _getButton(
            () {
              int _reqId = _receivedRequests.where((element) => element.sender.id == user.id).first.id;
              _friendsBloc.add(RejectFriendRequestEvent(_authToken, _reqId));
            },
            "Decline",
          ),
        ],
      );
    }
    return Container();
  }

  Widget _getButton(VoidCallback onPressed, String text, {isFilled = false}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPressed,
      child: Container(
        child: Text(
          text,
          style: TextStyle(
            color: isFilled ? ColorConstants.white : ColorConstants.lightPrimaryColor,
            fontSize: 11,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 7.0),
        decoration: BoxDecoration(
          color: isFilled ? ColorConstants.lightPrimaryColor : ColorConstants.white,
          border: Border.all(color:ColorConstants.lightPrimaryColor),
          borderRadius: BorderRadius.all(Radius.circular(4))
        ),
      ),
    );
  }
}