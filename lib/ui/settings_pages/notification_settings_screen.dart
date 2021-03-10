import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/ui/shared_widgets/banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class NotificationSettingsScreen extends StatefulWidget {
  @override
  _NotificationSettingsScreenState createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  List<String> _settingsText = ["Friend requests", "Stories", "Prayer notes", "Prayer invitations"];
  List<bool> _toggleStatus = [true, true, true, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(height: 1.0, color: ColorConstants.gray),
              BannerWidget(text: "NOTIFICATIONS SETTINGS"),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Icon(Icons.notifications, color: ColorConstants.lightPrimaryColor, size: 80.0),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Show notifications only about",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
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

  Widget _getDividerWithPadding() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Divider(height: 1.0, color: ColorConstants.gray),
    );
  }

  Widget _getSettingsRow(int index) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _settingsText[index],
          ),
          FlutterSwitch(
            width: 125.0,
            height: 55.0,
            activeColor: ColorConstants.lightPrimaryColor,
            toggleSize: 45.0,
            value: _toggleStatus[index],
            borderRadius: 30.0,
            padding: 8.0,
            onToggle: (val) {
              setState(() {
                _toggleStatus[index] = val;
              });
            },
          ),
        ],
      ),
    );
  }
}
