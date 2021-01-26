import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _getImage(),
            _getText(),
          ],
        ),
      ),
    );
  }

  _getImage() {
    return Expanded(
      child: Center(
        child: Text("To be Replaced by images"),
      ),
    );
  }
  
  _getText() {
    return Container(
      padding: EdgeInsets.all(20),
      child: RichText(
         text: TextSpan(
           text: StringConstants.CHERISHED,
           style: TextStyle(
             color: ColorConstants.lightPrimaryColor,
             fontSize: 20,
           ),
           children: [
             TextSpan(
               text: StringConstants.PRAYERS,
               style: TextStyle(
                 color: ColorConstants.gray,
                 fontSize: 20,
               ),
             ),
           ],
         ),
      ),
    );
  }
}
