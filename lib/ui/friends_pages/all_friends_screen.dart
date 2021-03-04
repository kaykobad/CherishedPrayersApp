import 'dart:async';

import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/data/network/api_endpoints.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/ui/friends_pages/firends_bloc/friends_bloc.dart';
import 'package:cherished_prayers/ui/friends_pages/firends_bloc/friends_event.dart';
import 'package:cherished_prayers/ui/friends_pages/firends_bloc/friends_state.dart';
import 'package:cherished_prayers/ui/shared_widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AllFriendsScreen extends StatefulWidget {
  @override
  _AllFriendsScreenState createState() => _AllFriendsScreenState();
}

class _AllFriendsScreenState extends State<AllFriendsScreen> {
  AppDataStorage _appDataStorage;
  int _myId;
  FriendsBloc _friendsBloc;
  List<SingleFriendResponse> _friends = [];
  List<SingleFriendResponse> _showAbleFriends = [];
  StreamSubscription<FriendsState> _friendsBlocListener;

  @override
  void initState() {
    super.initState();
    _appDataStorage = RepositoryProvider.of<AppDataStorage>(context);
    _friendsBloc = _appDataStorage.friendsBloc;
    _myId = _appDataStorage.userData.id;
    _friendsBloc.add(FetchAllFriendsEvent(_appDataStorage.authToken));
    _listenFriendsBloc();
  }

  @override
  dispose() {
    _friendsBlocListener?.cancel();
    super.dispose();
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
          _friends = state.friends.allFriends;
          _showAbleFriends = state.friends.allFriends;
        });
      } else if (state is UnFriendSuccessState) {
        await EasyLoading.dismiss();
        EasyLoading.showSuccess("Unfriend successful");
        _friends.removeWhere((element) => element.friend.id == state.userId);
        _showAbleFriends.removeWhere((element) => element.friend.id == state.userId);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                _getSearchWidget(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your Friends",
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
                  itemBuilder: (context, index) => buildItem(_friends[index].friend),
                  itemCount: _friends.length,
                ),
              ],
            ),
          ),
        ),
      ),
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
            hintText: "Search friend",
            isDense: true,
            fillColor: ColorConstants.gray,
          ),
        ),
        suggestionsCallback: (pattern) async {
          _showAbleFriends = _friends.where((element) => element.friend.firstName.toLowerCase().contains(pattern.toLowerCase())).toList();
          return _showAbleFriends;
        },
        itemBuilder: (context, suggestion) {
          return buildItem(suggestion.friend);
        },
        onSuggestionSelected: (suggestion) {
          // NavigationHelper.push(context, ChatScreen(thread: Thread.fromJson(suggestion.doc)));
        },
      ),
    );
  }

  Widget buildItem(GenericUserResponse user) {
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
            GestureDetector(
              child: Icon(
                Icons.email_outlined,
                color: ColorConstants.lightPrimaryColor,
              ),
              onTap: () {
                print("Message");
              },
            ),
            PopupMenuButton(
              itemBuilder: (_) => [
                PopupMenuItem(child: Text("Unfriend"), value: user),
              ],
              onSelected: (value) {
                print("$value user unfriend initiated!");
                _showUnFriendDialog(value);
              },
              icon: Icon(Icons.more_vert, color: ColorConstants.lightPrimaryColor),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Divider(color: Colors.grey[400], height: 1.0),
        SizedBox(height: 12.0),
      ],
    );
  }

  _showUnFriendDialog(GenericUserResponse user) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Unfriend ${user.firstName}'),
          content: Text("Are you sure you want to unfriend ${user.firstName}?"),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: ColorConstants.lightPrimaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Unfriend', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                _friendsBloc.add(UnFriendEvent(_appDataStorage.authToken, user.id));
              },
            ),
          ],
        );
      },
    );
  }

}
