import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/data/network/api_endpoints.dart';
import 'package:cherished_prayers/helpers/firebase_helper.dart';
import 'package:cherished_prayers/ui/shared_widgets/avatar.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final SingleCommentResponse comment;
  final bool isMyComment;
  final Function(int) likeCallback;
  final Function(int) deleteCallback;
  final Function(String, int) updateCallback;

  CommentCard({
    Key key,
    this.comment,
    this.isMyComment = false,
    this.likeCallback,
    this.deleteCallback,
    this.updateCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _getHeader(context),
          SizedBox(height: 4.0),
          _getComment(),
          _getLikeBar(context),
          SizedBox(height: 4.0),
          Divider(height: 1.0, color: ColorConstants.gray),
        ],
      ),
    );
  }

  Widget _getHeader(BuildContext context) {
    String date = getAbbreviatedDateTimeFromString(comment.dateCreated);

    return Row(
      children: [
        SizedBox(width: 8.0),
        CustomAvatar(url: comment.author.avatar == null ? null : ApiEndpoints.URL_ROOT + comment.author.avatar, size: 36),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment.author.firstName,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  fontSize: 13,
                  color: ColorConstants.gray,
                ),
              ),
            ],
          ),
        ),
        if (isMyComment) PopupMenuButton(
          itemBuilder: (_) => [
            PopupMenuItem(child: Text("Update Comment"), value: 1),
            PopupMenuItem(child: Text("Delete Comment"), value: 2),
          ],
          onSelected: (value) {
            if (value == 2) deleteCallback(comment.id);
            else _showUpdateDialog(context);
          },
          icon: Icon(Icons.more_vert, color: ColorConstants.lightPrimaryColor),
        ),
      ],
    );
  }

  Widget _getComment() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          comment.comment,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Widget _getLikeBar(BuildContext context){
    return Row(
      children: [
        MaterialButton(
          minWidth: 0,
          onPressed: () {
            likeCallback(comment.id);
          },
          textColor: ColorConstants.lightPrimaryColor,
          child: Icon(
            Icons.thumb_up_alt_outlined,
            size: 24,
          ),
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            side: BorderSide.none,
          ),
        ),
        Text("${comment.totalLikes}"),
      ],
    );
  }

  void _showUpdateDialog(BuildContext context) {
    TextEditingController _controller = TextEditingController(text: comment.comment);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Comment'),
            content: Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: ColorConstants.gray,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
              ),
              child: TextField(
                controller: _controller,
                maxLines: null,
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 14),
                  hintText: 'Update comment...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14.0),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel', style: TextStyle(color: Colors.red)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Update', style: TextStyle(color: ColorConstants.lightPrimaryColor)),
                onPressed: () {
                  updateCallback(_controller.text, comment.id);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }
}
