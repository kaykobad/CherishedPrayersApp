import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      backgroundColor: ColorConstants.darkPrimaryColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _getLogo(),
                  _getHeader(StringConstants.TOS_PAGE_TITLE_1, ColorConstants.lightPrimaryColor),
                  SizedBox(height: 16.0),
                  _getParagraph(StringConstants.PP_P_1),
                  SizedBox(height: 20.0),
                  _getHeader(StringConstants.PP_H_2, ColorConstants.white),
                  _getQuoteView(StringConstants.PP_SH_1),
                  _getParagraph(StringConstants.PP_P_2),
                  _getQuoteView(StringConstants.PP_SH_2),
                  _getParagraph(StringConstants.PP_P_3),
                  _getQuoteView(StringConstants.PP_SH_3),
                  _getParagraph(StringConstants.PP_P_4),
                  _getQuoteView(StringConstants.PP_SH_4),
                  _getParagraph(StringConstants.PP_P_5),
                  SizedBox(height: 20.0),
                  _getHeader(StringConstants.PP_H_3, ColorConstants.white),
                  SizedBox(height: 16.0),
                  _getParagraph(StringConstants.PP_P_6),
                  _getQuoteView(StringConstants.PP_SH_5),
                  _getParagraph(StringConstants.PP_P_7),
                  _getQuoteView(StringConstants.PP_SH_6),
                  _getParagraph(StringConstants.PP_P_8),
                  _getQuoteView(StringConstants.PP_SH_7),
                  _getParagraph(StringConstants.PP_P_9),
                  SizedBox(height: 20.0),
                  _getHeader(StringConstants.PP_H_4, ColorConstants.white),
                  SizedBox(height: 16.0),
                  _getParagraph(StringConstants.PP_P_10),
                  SizedBox(height: 14.0),
                  _getParagraph(StringConstants.PP_P_11),
                  SizedBox(height: 14.0),
                  _getParagraph(StringConstants.PP_P_12),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: ColorConstants.darkPrimaryColor,
      iconTheme: IconThemeData(color: ColorConstants.lightPrimaryColor),
      title: Text(
        StringConstants.PP_PAGE_HEADER,
        style: TextStyle(color: ColorConstants.white),
      ),
    );
  }

  Widget _getLogo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Center(
        child: Image.asset(
          AssetConstants.PP,
          width: 84,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _getHeader(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _getParagraph(String text) {
    return Text(
      text,
      style: TextStyle(
        color: ColorConstants.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _getQuoteView(String text) {
    return Container(
      margin: EdgeInsets.fromLTRB(24.0, 16.0, 0.0, 16.0),
      padding: EdgeInsets.fromLTRB(14.0, 5.0, 0.0, 5.0),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: ColorConstants.lightPrimaryColor,
            width: 4.0,
          )
        )
      ),
      child: Text(
        text,
        style: TextStyle(
          color: ColorConstants.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}