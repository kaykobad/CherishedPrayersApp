import 'package:cached_network_image/cached_network_image.dart';
import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final String url;
  final double size;

  const CustomAvatar({Key key, this.url, this.size=20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider _placeholderImage = AssetImage(AssetConstants.PROFILE_PICTURE);

    if (url == null) {
      return CircleAvatar(
        backgroundImage: _placeholderImage,
        backgroundColor: ColorConstants.white,
        radius: size,
      );
    }

    return CircleAvatar(
      backgroundColor: ColorConstants.white,
      backgroundImage: NetworkImage(url),
      radius: size,
    );
  }

}