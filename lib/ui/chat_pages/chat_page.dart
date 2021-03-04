import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/data/network/api_endpoints.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/ui/shared_widgets/avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cherished_prayers/helpers/firebase_helper.dart';
import 'package:image_picker/image_picker.dart';

import 'full_photo_view.dart';

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

  AppBar _getAppbarWithAvatar() {
    return AppBar(
      title: RichText(
        text: TextSpan(
          text: "With ",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: ColorConstants.black,
            fontSize: 18,
          ),
          children: [
            TextSpan(
              text: t.getReceiverName(_myId),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: ColorConstants.gray,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
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
    String fileName = getCurrentTimeStamp().toString();
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
      int sentTime = getCurrentTimeStamp();
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
        } else {
          t.firstUserUnseenMessageCount += 1;
          t.secondUserUnseenMessageCount = 0;
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

    if (m.senderId == _myId) {
      // Right (my message)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Text(
              getLocalDateTimeFromTimeStamp(m.sentDate),
              style: TextStyle(fontSize: 10.0, color: ColorConstants.gray),
            ),
          ),
          Row(
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
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => FullPhoto(url: m.message)),
                        );
                      },
                      padding: EdgeInsets.all(0),
                    ),
                    margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
                  ),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
        ],
      );
    } else {
      // Left (peer message)
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                getLocalDateTimeFromTimeStamp(m.sentDate),
                style: TextStyle(fontSize: 10.0, color: ColorConstants.gray),
              ),
            ),
            Row(
              children: <Widget>[
                m.type == 0
                    ? Container(
                        child: Text(
                          m.message,
                          style: TextStyle(color: Colors.black),
                        ),
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        width: 200.0,
                        decoration: BoxDecoration(color: ColorConstants.backGroundGray, borderRadius: BorderRadius.circular(8.0)),
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
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => FullPhoto(url: m.message)),
                          );
                        },
                        padding: EdgeInsets.all(0),
                      ),
                      margin: EdgeInsets.only(left: 10.0),
                    ),
                SizedBox(width: 16.0),
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
              ],
            ),
          ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppbarWithAvatar(),
      body: SafeArea(
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
    int deletedUntil;
    if (t.firstUserId == _myId) deletedUntil = t.firstUserDeleteUntil ?? 0;
    else deletedUntil = t.secondUserDeleteUntil ?? 0;

    return Flexible(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Messages')
            .where("threadId", isEqualTo: t.id)
            .where("sentDate", isGreaterThan: deletedUntil)
            .orderBy('sentDate', descending: true)
            .limit(_limit)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.lightPrimaryColor)));
          } else {
            listMessage.addAll(snapshot.data.docs);
            // Set my unseen message to zero
            FirebaseFirestore.instance.runTransaction((transaction) async {
              var documentReference = FirebaseFirestore.instance
                  .collection('Threads')
                  .doc(t.id);
              if (t.firstUserId == _myId) {
                transaction.update(documentReference, {'firstUserUnseenMessageCount': 0});
                t.firstUserUnseenMessageCount = 0;
              }
              else {
                transaction.update(documentReference, {'secondUserUnseenMessageCount': 0});
                t.secondUserUnseenMessageCount = 0;
              }
            });
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
