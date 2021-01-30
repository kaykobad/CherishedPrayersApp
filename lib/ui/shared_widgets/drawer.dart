import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  final String name;
  final String religion;

  const NavigationDrawer({Key key, this.name, this.religion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          color: ColorConstants.drawerColor,
          child: Column(
            children: [
              _getAvatar(),
              _getName(),
              _getReligion(),
              SizedBox(height: 20.0),
              _getNavRow(AssetConstants.NAV_PROFILE, StringConstants.MY_PROFILE, (){print("My profile");}),
              _getNavRow(AssetConstants.NAV_SETTINGS, StringConstants.SETTINGS, (){print("Settings");}),
              _getNavRow(AssetConstants.NAV_NOTIFICATION, StringConstants.NOTIFICATIONS, (){print("Notifications");}),
              _getNavRow(AssetConstants.NAV_TOS, StringConstants.TOS, (){print("TOS");}),
              _getNavRow(AssetConstants.NAV_PRIVACY_POLICY, StringConstants.PP, (){print("PP");}),
              _getNavRow(AssetConstants.NAV_LIKE, StringConstants.FEEDBACK, (){print("Give Feedback");}),
              _getNavRow(AssetConstants.NAV_RATE_US, StringConstants.RATE, (){print("Rate Us");}),
              SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _getNavRow(String assetPath, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: Image.asset(
                assetPath,
                height: 24,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.fromLTRB(5.0, 14.0, 10.0, 14.0),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: ColorConstants.gray,
                  ),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  style: TextStyle(
                    color: ColorConstants.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _getAvatar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(30.0, 60.0, 30.0, 16.0),
      child: Center(
        child: Image.asset(
          AssetConstants.NAV_AVATAR,
          height: 84,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _getName() {
    return Text(
      name,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: ColorConstants.white,
        fontWeight: FontWeight.w500,
        fontSize: 22,
      ),
    );
  }

  Widget _getReligion() {
    return Text(
      religion,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: ColorConstants.gray,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
    );
  }
}
