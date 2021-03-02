import 'package:badges/badges.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/helpers/navigation_helper.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/ui/chat_pages/chat_page.dart';
import 'package:cherished_prayers/ui/shared_widgets/avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AllThreadsPage extends StatefulWidget {
  @override
  _AllThreadsPageState createState() => _AllThreadsPageState();
}

class _AllThreadsPageState extends State<AllThreadsPage> {
  // TODO: Add menu popup functionality to delete message
  // TODO: Add delete thread functionality
  AppDataStorage _appDataStorage;
  int _myId;
  List<QueryDocumentSnapshot> threadList = new List.from([]);

  @override
  void initState() {
    super.initState();
    _appDataStorage = RepositoryProvider.of<AppDataStorage>(context);
    _myId = _appDataStorage.userData.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Threads')
                  .where("users", arrayContains: _appDataStorage.userData.id)
                  .orderBy("lastUpdateTimeStamp", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.lightPrimaryColor),
                    ),
                  );
                } else {
                  threadList = snapshot.data.docs;
                  return Column(
                    children: [
                      _getSearchWidget(),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(10.0),
                        itemBuilder: (context, index) => buildItem(snapshot.data.docs[index]),
                        itemCount: snapshot.data.docs.length,
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSearchWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
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
            hintText: "Search a specific chat",
            isDense: true,
            fillColor: ColorConstants.gray,
          ),
        ),
        suggestionsCallback: (pattern) async {
          return threadList.where((element) {
            Thread temp = Thread.fromJson(element.data());
            return temp.getReceiverName(_myId).toLowerCase().contains(pattern.toLowerCase());
          }).toList();
        },
        itemBuilder: (context, suggestion) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: buildItem(suggestion),
          );
        },
        onSuggestionSelected: (suggestion) {
          NavigationHelper.push(context, ChatScreen(thread: Thread.fromJson(suggestion.doc)));
        },
      ),
    );
  }

  Widget buildItem(DocumentSnapshot document) {
    Thread t = Thread.fromJson(document.data());
    int myId = _appDataStorage.userData.id;
    int unreadMessageCount = t.getUnseenMessageCount(myId);
    String avatarPath = t.getReceiverAvatar(myId);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        NavigationHelper.push(context, ChatScreen(thread: t));
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAvatar(url: avatarPath == "" ? null : avatarPath, size: 60.0),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          t.getReceiverName(myId),
                          style: TextStyle(
                            color: ColorConstants.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          t.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: unreadMessageCount == 0 ? ColorConstants.gray : ColorConstants.black),
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
              if (unreadMessageCount != 0) Badge(
                toAnimate: false,
                shape: BadgeShape.circle,
                badgeColor: ColorConstants.lightPrimaryColor,
                badgeContent: Text('$unreadMessageCount', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(width: 4.0),
              Icon(Icons.more_vert, color: ColorConstants.lightPrimaryColor),
            ],
          ),
          SizedBox(height: 12.0),
          Divider(color: Colors.grey[400], height: 1.0),
          SizedBox(height: 12.0),
        ],
      ),
    );
  }
}
