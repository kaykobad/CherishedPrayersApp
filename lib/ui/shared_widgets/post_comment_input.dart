import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/ui/shared_widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostCommentInputWidget extends StatelessWidget {
  final String url;
  final bool isComment;
  final Function(String) callback;
  final TextEditingController _controller = TextEditingController();

  PostCommentInputWidget({Key key, this.url, this.isComment=false, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: Row(
        children: [
          CustomAvatar(url: url, size: isComment ? 35 : 50),
          SizedBox(width: 5.0),
          Expanded(
            child: Container(
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
                  hintText: isComment ? 'Write a comment...' : 'Write a post...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14.0),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          MaterialButton(
            minWidth: 0,
            onPressed: () {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              callback(_controller.text);
            },
            color: ColorConstants.lightPrimaryColor,
            textColor: Colors.white,
            child: Icon(
              Icons.send,
              size: 24,
            ),
            padding: EdgeInsets.all(10),
            shape: CircleBorder(),
          ),
        ],
      ),
    );
  }
}
