import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:flutter/material.dart';

class SettingsRow extends StatelessWidget {
  final IconData iconData;
  final String text;
  final VoidCallback onPressed;

  SettingsRow({Key key, this.iconData, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.translucent,
        child: Row(
          children: [
            Icon(iconData, color: ColorConstants.gray, size: 36),
            SizedBox(width: 20.0),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: ColorConstants.black,
                  fontSize: 18,
                ),
              ),
            ),
            Icon(Icons.arrow_forward, color: ColorConstants.lightPrimaryColor, size: 24)
          ],
        ),
      ),
    );
  }
}
