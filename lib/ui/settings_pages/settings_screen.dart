import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/helpers/navigation_helper.dart';
import 'package:cherished_prayers/ui/profile_tos_pp_feedback/pp_screen.dart';
import 'package:cherished_prayers/ui/profile_tos_pp_feedback/tos_screen.dart';
import 'package:cherished_prayers/ui/settings_pages/blocked_user_screen.dart';
import 'package:cherished_prayers/ui/settings_pages/notification_settings_screen.dart';
import 'package:cherished_prayers/ui/settings_pages/report_a_bug_screen.dart';
import 'package:cherished_prayers/ui/shared_widgets/banner_widget.dart';
import 'package:cherished_prayers/ui/shared_widgets/settings_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'password_change_screen.dart';

class SettingsScreen extends StatefulWidget {
  final String status;

  const SettingsScreen({Key key, this.status=""}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.status != "") {
      EasyLoading.showSuccess(widget.status);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(height: 1.0, color: ColorConstants.gray),
              BannerWidget(text: "BASIC SETTINGS"),
              SettingsRow(iconData: Icons.email, text: "Update Email Address", onPressed: () {
                EasyLoading.showInfo("This feature will be implemented soon!");
              }),
              SettingsRow(iconData: Icons.lock, text: "Change Password", onPressed: () {
                NavigationHelper.push(context, PasswordChangeScreen());
              }),
              SettingsRow(iconData: Icons.notifications, text: "Manage Notifications", onPressed: () {
                NavigationHelper.push(context, NotificationSettingsScreen());
              }),
              SizedBox(height: 10.0),
              Divider(height: 1.0, color: ColorConstants.gray),
              BannerWidget(text: "APP SETTINGS"),
              SettingsRow(iconData: Icons.block, text: "Manage Blocked Accounts", onPressed: () {
                NavigationHelper.push(context, BlockedUsersScreen());
              }),
              SizedBox(height: 10.0),
              Divider(height: 1.0, color: ColorConstants.gray),
              BannerWidget(text: "ABOUT"),
              SettingsRow(iconData: Icons.privacy_tip, text: "Privacy Policy", onPressed: () {
                NavigationHelper.push(context, PrivacyPolicyScreen());
              }),
              SettingsRow(iconData: Icons.check_circle, text: "Terms of Use", onPressed: () {
                NavigationHelper.push(context, TermsOfServiceScreen());
              }),
              SettingsRow(iconData: Icons.settings, text: "Report a Bug", onPressed: () {
                NavigationHelper.push(context, ReportABugScreen());
              }),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      title: Text("Settings", style: TextStyle(color: ColorConstants.black)),
      centerTitle: true,
      backgroundColor: ColorConstants.white,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorConstants.lightPrimaryColor),
    );
  }
}
