import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _getTitle(),
            _getSubTitle(),
            _getStartedButton(),
            _getImage(),
          ],
        ),
      ),
    );
  }

  Widget _getTitle() {
    return Text(
      StringConstants.TITLE,
      style: TextStyle(
        fontSize: 32,
        color: ColorConstants.black,
      ),
    );
  }

  Widget _getSubTitle() {
    return Text(
      StringConstants.SUB_TITLE,
      style: TextStyle(
        fontSize: 16,
        color: ColorConstants.gray,
      ),
    );
  }

  Widget _getStartedButton() {
    return RaisedButton(
      child: Text(
        StringConstants.GET_STARTED_BUTTON,
      ),
      onPressed: () => print("Get Started")
    );
  }

  Widget _getImage() {
    return Expanded(
      child: Center(
        child: Text("To be replaced by image."),
      ),
    );
  }
}
