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
    fontFamily: "Poppins",
    buttonTheme: ButtonThemeData(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      buttonColor: ColorConstants.lightPrimaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0))
    ),
    textTheme: TextTheme(
      headline4: TextStyle(fontSize: 42.0, fontWeight: FontWeight.w500),
      headline5: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
      headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
      bodyText1: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
      bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
      button: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
    ),
    dividerColor: Colors.white54,
  );

  static final darkTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    primaryColor: ColorConstants.darkPrimaryColor,
    brightness: Brightness.dark,
    backgroundColor: ColorConstants.darkBackgroundColor,
    accentColor: Colors.black45,
    accentIconTheme: IconThemeData(color: Colors.black),
    hintColor: ColorConstants.hintGray,
    fontFamily: "Poppins",
    buttonTheme: ButtonThemeData(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        buttonColor: ColorConstants.lightPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))
    ),
    textTheme: TextTheme(
      headline4: TextStyle(fontSize: 42.0, fontWeight: FontWeight.w500),
      headline5: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
      headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
      bodyText1: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
      bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
      button: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
    ),
    dividerColor: Colors.black12,
  );
}