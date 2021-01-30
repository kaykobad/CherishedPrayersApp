import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/helpers/navigation_helper.dart';
import 'package:cherished_prayers/ui/home_pages/home_screen.dart';
import 'package:cherished_prayers/ui/profile_tos_pp_feedback/feedback_screen.dart';
import 'package:cherished_prayers/ui/profile_tos_pp_feedback/pp_screen.dart';
import 'package:cherished_prayers/ui/shared_widgets/rounded_corner_button.dart';
import 'package:flutter/material.dart';

import 'authentication_selection_screen.dart';

class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getTitle(),
            _getSubTitle(),
            _getStartedButton(context),
            _getImage(),
          ],
        ),
      ),
    );
  }

  Widget _getTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 20.0, 20.0, 16.0),
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

  Widget _getStartedButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
      child: RoundedCornerButton(StringConstants.GET_STARTED_BUTTON, (){
        // NavigationHelper.push(context, AuthenticationSelectionScreen());
        NavigationHelper.push(context, HomeScreen());
      }),
    );
  }

  Widget _getImage() {
    return Expanded(
      child: Center(
        child: Image.asset(
          AssetConstants.GIRL_SITTING,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
