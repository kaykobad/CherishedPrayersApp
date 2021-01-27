import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/ui/shared_widgets/rounded_corner_button.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 16.0),
      child: Text(
        StringConstants.TITLE,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
          color: ColorConstants.black,
        ),
      ),
    );
  }

  Widget _getSubTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 24.0),
      child: Text(
        StringConstants.SUB_TITLE,
        style: TextStyle(
          fontSize: 16,
          color: ColorConstants.gray,
        ),
      ),
    );
  }

  Widget _getStartedButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
      child: RoundedCornerButton(StringConstants.GET_STARTED_BUTTON, (){}),
    );
  }

  Widget _getImage() {
    return Expanded(
      child: Center(
        child: Image.asset(
          AssetConstants.GIRL_SITTING,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
