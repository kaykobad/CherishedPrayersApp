import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/ui/shared_widgets/outlined_button.dart';
import 'package:cherished_prayers/ui/shared_widgets/rounded_corner_button.dart';
import 'package:flutter/material.dart';

class AuthenticationSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            _getImage(height),
            _getTitle(),
            Spacer(),
            _getSignUpButton(context),
            _getSignInButton(context),
          ],
        ),
      ),
    );
  }

  Widget _getImage(double height) {
    return Center(
      child: Image.asset(
        AssetConstants.BOY_SITTING,
        height: height * 0.4,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _getTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 16.0),
      child: Text(
        StringConstants.FIND_A_WAY,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: ColorConstants.black,
        ),
      ),
    );
  }

  Widget _getSignUpButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 14.0),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedRoundedButton(StringConstants.SIGN_UP, (){
          // NavigationHelper.push(context, AuthenticationSelectionScreen());
        }),
      ),
    );
  }

  Widget _getSignInButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
      child: SizedBox(
        width: double.infinity,
        child: RoundedCornerButton(StringConstants.SIGN_IN, (){
          // NavigationHelper.push(context, AuthenticationSelectionScreen());
        }),
      ),
    );
  }
}
