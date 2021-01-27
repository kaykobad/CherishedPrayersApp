import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:flutter/material.dart';

void showCustomDialog(BuildContext context, String title, String message, DialogType type) {
  AwesomeDialog(
    context: context,
    dialogType: type,
    borderSide: BorderSide(color: Colors.green, width: 2),
    width: 280,
    buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
    headerAnimationLoop: false,
    animType: AnimType.LEFTSLIDE,
    title: 'INFO',
    desc: 'Dialog description here...',
    showCloseIcon: true,
    btnCancelOnPress: () {},
    btnOkOnPress: () {},
    btnOkColor: ColorConstants.lightPrimaryColor,
  )..show();
}