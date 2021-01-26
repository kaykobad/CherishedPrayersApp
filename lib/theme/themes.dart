import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.lightGreen,
    primaryColor: ColorConstants.lightPrimaryColor,
    brightness: Brightness.light,
    backgroundColor: ColorConstants.lightBackgroundColor,
    accentColor: Colors.lightGreenAccent,
    accentIconTheme: IconThemeData(color: Colors.white),
    hintColor: ColorConstants.hintGray,
    buttonTheme: ButtonThemeData(
      padding: EdgeInsets.all(12.0),
      buttonColor: ColorConstants.lightPrimaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))
    ),
    textTheme: TextTheme(
      button: TextStyle(color: ColorConstants.white),
      bodyText2: TextStyle(color: ColorConstants.black),
      headline6: TextStyle(color: ColorConstants.black),
      subtitle1: TextStyle(color: ColorConstants.black),
      subtitle2: TextStyle(color: ColorConstants.gray),
    ),
    dividerColor: Colors.white54,
  );

  static final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
  );
}