import 'package:cached_network_image/cached_network_image.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllThreadsPage extends StatefulWidget {
  @override
  _AllThreadsPageState createState() => _AllThreadsPageState();
}

class _AllThreadsPageState extends State<AllThreadsPage> {
  AppDataStorage _appDataStorage;

  @override
  void initState() {
    super.initState();
    _appDataStorage = RepositoryProvider.of<AppDataStorage>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Threads').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.lightPrimaryColor),
                  ),
                );
              } else {
                return ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemBuilder: (context, index) => buildItem(snapshot.data.docs[index]),
                  itemCount: snapshot.data.docs.length,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: ColorConstants.lightPrimaryColor),
      title: Text(
        StringConstants.THREAD_HEADER,
        style: TextStyle(color: ColorConstants.black),
      ),
    );
  }

  Widget buildItem(DocumentSnapshot document) {
    Thread t = Thread.fromJson(document.data());
    int myId = _appDataStorage.userData.id;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Material(
          child: t.getReceiverAvatar(myId) != null
              ? CachedNetworkImage(
                placeholder: (context, url) => Container(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.0,
                    valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.lightPrimaryColor),
                  ),
                  width: 50.0,
                  height: 50.0,
                  padding: EdgeInsets.all(15.0),
                ),
                imageUrl: t.getReceiverAvatar(myId),
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              )
              : Icon(
                Icons.account_circle,
                size: 50.0,
                color: ColorConstants.gray,
              ),
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          clipBehavior: Clip.hardEdge,
        ),
        Flexible(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    _appDataStorage.userData.firstName,
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
                    style: TextStyle(color: ColorConstants.gray),
                  ),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                )
              ],
            ),
            margin: EdgeInsets.only(left: 20.0),
          ),
        ),
      ],
    );
  }
}
