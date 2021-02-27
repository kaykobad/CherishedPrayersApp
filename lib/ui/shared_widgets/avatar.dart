import 'package:cached_network_image/cached_network_image.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final String url;
  final double size;

  const CustomAvatar({Key key, this.url, this.size=20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: url != null
        ? CachedNetworkImage(
            placeholder: (context, url) => Container(
              child: CircularProgressIndicator(
                strokeWidth: 1.0,
                valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.lightPrimaryColor),
              ),
              width: size,
              height: size,
              padding: EdgeInsets.all(10.0),
            ),
            errorWidget: (_, __, ___) => Icon(
              Icons.account_circle,
              size: size,
              color: ColorConstants.lightPrimaryColor,
            ),
            imageUrl: url,
            width: size,
            height: size,
            fit: BoxFit.cover,
          )
          : Icon(
              Icons.account_circle,
              size: size,
              color: ColorConstants.lightPrimaryColor,
            ),
      borderRadius: BorderRadius.all(Radius.circular(size/2)),
      clipBehavior: Clip.hardEdge,
    );
  }
}