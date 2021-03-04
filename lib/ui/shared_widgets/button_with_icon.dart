import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:flutter/material.dart';

class RoundedCornerButtonWithIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const RoundedCornerButtonWithIcon(this.icon, this.text, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(horizontal: 26.0, vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color: ColorConstants.white),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: ColorConstants.white,
            ),
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}