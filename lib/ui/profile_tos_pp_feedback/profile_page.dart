import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _getBgImage(),
      ],
    );
  }

  Align _getBgImage() {
    return Align(
      alignment: Alignment.topCenter,
      child: Image.asset(
        AssetConstants.PROFILE_BG_2,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }
}
