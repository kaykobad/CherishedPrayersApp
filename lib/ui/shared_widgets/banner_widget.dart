import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  final String text;

  BannerWidget({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: ColorConstants.backGroundGray,
      padding: EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 10.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 17,
          color: ColorConstants.hintGray,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
