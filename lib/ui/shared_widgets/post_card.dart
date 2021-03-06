import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/data/network/api_endpoints.dart';
import 'package:cherished_prayers/helpers/firebase_helper.dart';
import 'package:cherished_prayers/helpers/navigation_helper.dart';
import 'package:cherished_prayers/ui/feed_pages/post_details_screen.dart';
import 'package:cherished_prayers/ui/shared_widgets/avatar.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final GenericPostResponse post;
  final bool isMyPost;
  final Function(int) likeCallback;
  final Function(int) deleteCallback;
  final Function(String, int) updateCallback;
  final bool isFromDetailPage;

  PostCard({
    Key key,
    this.post,
    this.isMyPost = false,
    this.likeCallback,
    this.deleteCallback,
    this.updateCallback,
    this.isFromDetailPage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: _getHeader(context),
            onTap: () {
              if (!isFromDetailPage) NavigationHelper.push(context, PostDetailsScreen(postId: post.id));
            },
          ),
          SizedBox(height: 4.0),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: _getPost(),
            onTap: () {
              if (!isFromDetailPage) NavigationHelper.push(context, PostDetailsScreen(postId: post.id));
            },
          ),
          _getLikeBar(context),
          SizedBox(height: 4.0),
          if (!isFromDetailPage) Divider(height: 1.0, color: ColorConstants.gray),
        ],
      ),
    );
  }

  Widget _getHeader(BuildContext context) {
    String date = getAbbreviatedDateTimeFromString(post.dateCreated);

    return Row(
      children: [
        SizedBox(width: 8.0),
        CustomAvatar(url: post.author.avatar == null ? null : ApiEndpoints.URL_ROOT + post.author.avatar, size: 50),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.author.firstName,
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
        if (isMyPost) PopupMenuButton(
          itemBuilder: (_) => [
            PopupMenuItem(child: Text("Update Post"), value: 1),
            PopupMenuItem(child: Text("Delete Post"), value: 2),
          ],
          onSelected: (value) {
            if (value == 2) deleteCallback(post.id);
            else _showUpdateDialog(context);
          },
          icon: Icon(Icons.more_vert, color: ColorConstants.lightPrimaryColor),
        ),
      ],
    );
  }

  Widget _getPost() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          post.post,
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
            likeCallback(post.id);
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
        Text("${post.totalLikes}"),
        MaterialButton(
          minWidth: 0,
          onPressed: () {
            if (!isFromDetailPage) NavigationHelper.push(context, PostDetailsScreen(postId: post.id));
          },
          textColor: ColorConstants.lightPrimaryColor,
          child: Icon(
            Icons.comment_outlined,
            size: 24,
          ),
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            side: BorderSide.none,
          ),
        ),
        Text("${post.totalComments}"),
      ],
    );
  }

  void _showUpdateDialog(BuildContext context) {
    TextEditingController _controller = TextEditingController(text: post.post);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Post'),
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
                hintText: 'Update post...',
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
                updateCallback(_controller.text, post.id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }
}
