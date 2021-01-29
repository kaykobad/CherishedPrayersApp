import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:flutter/material.dart';

class MultilineTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const MultilineTextField(this.controller, this.hint);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 6,
      controller: controller,
      style: TextStyle(decoration: TextDecoration.none),
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorConstants.white,
        hintText: hint,
        contentPadding: EdgeInsets.fromLTRB(20, 12, 12, 16),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(style: BorderStyle.solid, color: ColorConstants.gray),
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
      ),
    );
  }
}
