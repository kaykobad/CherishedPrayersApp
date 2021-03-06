import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/data/network/api_endpoints.dart';
import 'package:cherished_prayers/helpers/firebase_helper.dart';
import 'package:cherished_prayers/ui/shared_widgets/avatar.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final PostResponse post;
  final bool isMyPost;
  final Function(int) likeCallback;
  final Function(int) deleteCallback;

  PostCard({Key key, this.post, this.isMyPost = false, this.likeCallback, this.deleteCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _getHeader(),
          SizedBox(height: 4.0),
          _getPost(),
          _getLikeBar(),
          SizedBox(height: 4.0),
          Divider(height: 1.0, color: ColorConstants.gray),
        ],
      ),
    );
  }

  Widget _getHeader() {
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

  Widget _getLikeBar(){
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
            print("Comment");
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
}
