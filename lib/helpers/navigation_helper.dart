import 'package:flutter/material.dart';

class NavigationHelper {
  static void push(BuildContext context, Widget targetPage) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => targetPage,
      ),
    );
  }

  static void pushReplacement(BuildContext context, Widget targetPage) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => targetPage,
      ),
    );
  }

  static void pushAndRemoveAll(BuildContext context, Widget targetPage) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) => targetPage,
      ),
      (route) => false,
    );
  }
}