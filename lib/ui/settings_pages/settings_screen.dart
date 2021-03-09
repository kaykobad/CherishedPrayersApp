import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/ui/shared_widgets/banner_widget.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
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
              Divider(height: 1.0, color: ColorConstants.gray),
              BannerWidget(text: "APP SETTINGS"),
              Divider(height: 1.0, color: ColorConstants.gray),
              BannerWidget(text: "ABOUT"),
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
