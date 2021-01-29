import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:flutter/material.dart';

class TermsOfServiceScreen extends StatelessWidget {

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
                  _getParagraph(StringConstants.TOS_P_1),
                  SizedBox(height: 20.0),
                  _getHeader(StringConstants.TOS_H_2, ColorConstants.white),
                  SizedBox(height: 16.0),
                  _getParagraph(StringConstants.TOS_P_2),
                  SizedBox(height: 16.0),
                  _getParagraph(StringConstants.TOS_P_3),
                  SizedBox(height: 10.0),
                  _getListView(context),
                  SizedBox(height: 24.0),
                  _getHeader(StringConstants.TOS_H_3, ColorConstants.white),
                  SizedBox(height: 16.0),
                  _getParagraph(StringConstants.TOS_P_4),
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
      leading: Icon(
        Icons.arrow_back,
        color: ColorConstants.lightPrimaryColor,
      ),
      title: Text(
        StringConstants.TOS_PAGE_HEADER,
        style: TextStyle(color: ColorConstants.white),
      ),
    );
  }

  Widget _getLogo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Center(
        child: Image.asset(
          AssetConstants.ARTICLE,
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

  Widget _getListView(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: StringConstants.LIST_TOS.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Icon(Icons.circle, color: ColorConstants.lightPrimaryColor, size: 12.0),
                ),
                SizedBox(width: 6.0),
                Expanded(child: _getParagraph(StringConstants.LIST_TOS[index])),
              ],
            ),
            SizedBox(height: 8.0),
          ],
        );
      },
    );
  }
}