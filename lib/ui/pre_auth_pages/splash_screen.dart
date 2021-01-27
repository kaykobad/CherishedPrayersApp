import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/helpers/navigation_helper.dart';
import 'package:cherished_prayers/ui/pre_auth_pages/get_stated_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      NavigationHelper.pushReplacement(context, GetStartedScreen());
    });
  }

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
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Image.asset(
            AssetConstants.APP_LOGO,
            height: 120,
          ),
        ),
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
             fontWeight: FontWeight.w500,
             color: ColorConstants.lightPrimaryColor,
             fontSize: 20,
           ),
           children: [
             TextSpan(
               text: StringConstants.PRAYERS,
               style: TextStyle(
                 fontWeight: FontWeight.w500,
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
