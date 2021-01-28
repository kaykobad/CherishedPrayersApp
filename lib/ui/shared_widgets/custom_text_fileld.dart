import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final Widget suffixWidget;

  const CustomTextField(this.controller, this.hint, this.obscureText, {this.suffixWidget});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(decoration: TextDecoration.none),
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorConstants.backGroundGray,
        hintText: hint,
        contentPadding: EdgeInsets.fromLTRB(20, 8, 8, 8),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(style: BorderStyle.none),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.lightPrimaryColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintStyle: TextStyle(
          fontSize: 16,
          color: ColorConstants.hintGray,
        ),
        suffixIcon: suffixWidget,
      ),
    );
  }
}
