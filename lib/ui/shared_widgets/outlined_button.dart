import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:flutter/material.dart';

class OutlinedRoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const OutlinedRoundedButton(this.text, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(horizontal: 26.0, vertical: 10.0),
      color: ColorConstants.white,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: ColorConstants.lightPrimaryColor,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
