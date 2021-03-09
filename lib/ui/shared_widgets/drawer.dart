import 'dart:io';

import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/helpers/navigation_helper.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/ui/home_pages/home_screen.dart';
import 'package:cherished_prayers/ui/profile_tos_pp_feedback/feedback_screen.dart';
import 'package:cherished_prayers/ui/profile_tos_pp_feedback/pp_screen.dart';
import 'package:cherished_prayers/ui/profile_tos_pp_feedback/tos_screen.dart';
import 'package:cherished_prayers/ui/settings_pages/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDrawer extends StatelessWidget {
  final String name;
  final String religion;

  const NavigationDrawer({Key key, this.name, this.religion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: ColorConstants.drawerColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _getAvatar(),
              _getName(),
              _getReligion(),
              SizedBox(height: 20.0),
              _getNavRow(AssetConstants.NAV_PROFILE, StringConstants.MY_PROFILE, (){
                Navigator.of(context).pop();
                NavigationHelper.push(context, HomeScreen(selectedIndex: 4));
              }),
              _getNavRow(AssetConstants.NAV_SETTINGS, StringConstants.SETTINGS, (){
                Navigator.of(context).pop();
                NavigationHelper.push(context, SettingsScreen());
              }),
              _getNavRow(AssetConstants.NAV_NOTIFICATION, StringConstants.NOTIFICATIONS, (){print("Notifications");}),
              _getNavRow(AssetConstants.NAV_TOS, StringConstants.TOS, (){
                Navigator.of(context).pop();
                NavigationHelper.push(context, TermsOfServiceScreen());
              }),
              _getNavRow(AssetConstants.NAV_PRIVACY_POLICY, StringConstants.PP, (){
                Navigator.of(context).pop();
                NavigationHelper.push(context, PrivacyPolicyScreen());
              }),
              _getNavRow(AssetConstants.NAV_LIKE, StringConstants.FEEDBACK, (){
                Navigator.of(context).pop();
                NavigationHelper.push(context, FeedBackScreen());
              }),
              _getNavRow(AssetConstants.NAV_RATE_US, StringConstants.RATE, () {
                _takeToAppStore(context);
              }),
              SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }

  void _takeToAppStore(BuildContext context) async {
    String packageName = RepositoryProvider.of<AppDataStorage>(context).packageName;

    String url = '';

    if (Platform.isAndroid) {
      url = "https://play.google.com/store/apps/details?id=" + packageName;
    } else {
      url = "market://details?id=" + packageName;
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
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
