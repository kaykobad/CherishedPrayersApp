import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final Thread thread;

  const ChatScreen({Key key, this.thread}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<QueryDocumentSnapshot> listMessage = new List.from([]);
  AppDataStorage _appDataStorage;
  int _limit = 20;
  int _limitIncrement = 20;
  File imageFile;
  bool isLoading;
  String imageUrl;
  int _myId;
  Thread t;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  _scrollListener() {
    if (listScrollController.offset >= listScrollController.position.maxScrollExtent && !listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _appDataStorage = RepositoryProvider.of<AppDataStorage>(context);
    listScrollController.addListener(_scrollListener);
    isLoading = false;
    imageUrl = '';
    _myId = _appDataStorage.userData.id;
    t = widget.thread;
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);

    if (imageFile != null) {
      setState(() {
        isLoading = true;
      });
      uploadFile();
    }
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(imageFile);
    (await uploadTask).ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl, 1);
      });
    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
      EasyLoading.showToast('This file is not an image', toastPosition: EasyLoadingToastPosition.bottom, dismissOnTap: true);
    });
  }

  void onSendMessage(String content, int type) {
    // type: 0 = text, 1 = image
    if (content.trim() != '') {
      int sentTime = DateTime.now().toUtc().millisecondsSinceEpoch;
      textEditingController.clear();

      var documentReference = FirebaseFirestore.instance
          .collection('Messages')
          .doc(sentTime.toString());

      // Sending message
      Message m = Message(t.id, _myId, sentTime, content, type);
      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          m.toJson(),
        );
      });

      // Updating thread
      FirebaseFirestore.instance.runTransaction((transaction) async {
        var documentReference = FirebaseFirestore.instance
            .collection('Threads')
            .doc(t.id);
        DocumentSnapshot documentSnapShot = await documentReference.get();
        t = Thread.fromJson(documentSnapShot.data());
        t.lastUpdateTimeStamp = sentTime;
        t.lastMessage = type == 0 ? m.message : "Sent and image";
        if (t.firstUserId == _myId) {
          t.firstUserUnseenMessageCount = 0;
          t.secondUserUnseenMessageCount += 1;
        }
        transaction.set(documentReference, t.toJson());
      });

      listScrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      EasyLoading.showToast('Please type message to send', toastPosition: EasyLoadingToastPosition.bottom, dismissOnTap: true);
    }
  }


  Widget buildItem(int index, DocumentSnapshot document) {
    Message m = Message.fromJson(document.data());

    // TODO: Fix date time show issue
    // TODO: Move sender avatar to right
    if (m.senderId == _myId) {
      // Right (my message)
      return Row(
        children: <Widget>[
          m.type == 0
          // Text
            ? Container(
                child: Text(
                  m.message,
                  style: TextStyle(color: Colors.white),
                ),
                padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                width: 200.0,
                decoration: BoxDecoration(color: ColorConstants.lightPrimaryColor, borderRadius: BorderRadius.circular(8.0)),
                margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
              )
            : Container(
                child: FlatButton(
                  child: Material(
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Container(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.lightPrimaryColor),
                        ),
                        width: 200.0,
                        height: 200.0,
                        padding: EdgeInsets.all(70.0),
                        decoration: BoxDecoration(
                          color: ColorConstants.gray,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Material(
                        child: Image.asset(
                          AssetConstants.IMAGE_NOT_AVAILABLE,
                          width: 200.0,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        clipBehavior: Clip.hardEdge,
                      ),
                      imageUrl: m.message,
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    clipBehavior: Clip.hardEdge,
                  ),
                  // onPressed: () {
                  //   Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) => FullPhoto(url: document.data()['content'])));
                  // },
                  padding: EdgeInsets.all(0),
                ),
                margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
              ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    } else {
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                isLastMessageLeft(index)
                    ? Material(
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Container(
                            child: CircularProgressIndicator(
                              strokeWidth: 1.0,
                              valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.lightPrimaryColor),
                            ),
                            width: 35.0,
                            height: 35.0,
                            padding: EdgeInsets.all(10.0),
                          ),
                          imageUrl: t.getReceiverAvatar(_myId),
                          width: 35.0,
                          height: 35.0,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                        clipBehavior: Clip.hardEdge,
                      )
                    : Container(width: 35.0),
                m.type == 0
                    ? Container(
                        child: Text(
                          m.message,
                          style: TextStyle(color: Colors.white),
                        ),
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        width: 200.0,
                        decoration: BoxDecoration(color: ColorConstants.gray, borderRadius: BorderRadius.circular(8.0)),
                        margin: EdgeInsets.only(left: 10.0),
                      )
                    : Container(
                      child: FlatButton(
                        child: Material(
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.lightPrimaryColor),
                              ),
                              width: 200.0,
                              height: 200.0,
                              padding: EdgeInsets.all(70.0),
                              decoration: BoxDecoration(
                                color: ColorConstants.gray,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Material(
                              child: Image.asset(
                                AssetConstants.IMAGE_NOT_AVAILABLE,
                                width: 200.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              clipBehavior: Clip.hardEdge,
                            ),
                            imageUrl: m.message,
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          clipBehavior: Clip.hardEdge,
                        ),
                        // onPressed: () {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => FullPhoto(url: document.data()['content'])));
                        // },
                        padding: EdgeInsets.all(0),
                      ),
                      margin: EdgeInsets.only(left: 10.0),
                    ),
              ],
            ),
            // Time
            isLastMessageLeft(index)
                ? Container(
                    child: Text(
                      DateFormat('dd MMM kk:mm').format(DateTime.fromMillisecondsSinceEpoch(m.sentDate)),
                      style: TextStyle(color: ColorConstants.hintGray, fontSize: 12.0, fontStyle: FontStyle.italic),
                    ),
                    margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
                  )
                : Container()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 && listMessage != null && listMessage[index - 1].data()['senderId'] == _myId) || index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 && listMessage != null && listMessage[index - 1].data()['senderId'] != _myId) || index == 0) {
      return true;
    } else {
      return false;
    }
  }

  // TODO: ADD APPBAR
  // TODO: Implement Push Notification
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  buildListMessage(),
                  buildInput(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: getImage,
                color: ColorConstants.lightPrimaryColor,
              ),
            ),
            color: Colors.white,
          ),
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                  onSendMessage(textEditingController.text, 0);
                },
                style: TextStyle(color: ColorConstants.black, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: ColorConstants.hintGray),
                ),
                focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => onSendMessage(textEditingController.text, 0),
                color: ColorConstants.lightPrimaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(border: Border(top: BorderSide(color: ColorConstants.gray, width: 0.5)), color: Colors.white),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Messages')
            .where("threadId", isEqualTo: t.id)
            .orderBy('sentDate', descending: true)
            .limit(_limit)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.lightPrimaryColor)));
          } else {
            listMessage.addAll(snapshot.data.docs);
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) => buildItem(index, snapshot.data.docs[index]),
              itemCount: snapshot.data.docs.length,
              reverse: true,
              controller: listScrollController,
            );
          }
        },
      ),
    );
  }
}
