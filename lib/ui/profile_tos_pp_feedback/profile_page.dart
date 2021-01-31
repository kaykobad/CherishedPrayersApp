import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double _height;
  double _width;
  AppDataStorage _appDataStorage;

  @override
  void initState() {
    super.initState();
    _appDataStorage = RepositoryProvider.of<AppDataStorage>(context);
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.center,
      children: [
        _getBgImage(),
        _getBody(),
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

  Widget _getCircleAvatar() {
    return Positioned(
      top: -80.0,
      child: Container(
        height: 160.0,
        width: 160.0,
        color: Colors.transparent,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 80,
              backgroundColor: ColorConstants.white,
              backgroundImage: NetworkImage(
                _appDataStorage.userData.avatar ?? 'https://www.clearmountainbank.com/wp-content/uploads/2020/04/male-placeholder-image.jpeg',
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: MaterialButton(
                onPressed: () {
                  print("Hello");
                },
                elevation: 2.0,
                color: Colors.white,
                child: Icon(
                  Icons.camera_alt,
                  size: 20.0,
                  color: ColorConstants.lightPrimaryColor,
                ),
                padding: EdgeInsets.all(0.0),
                shape: CircleBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBody() {
    return ListView(
      children: [
        Container(
          height: _height * 0.15,
          color: Colors.transparent,
        ),
        Stack(
          alignment: Alignment.center,
          overflow: Overflow.visible,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(16.0),
                  topRight: const Radius.circular(16.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 100.0, 12.0, 12.0),
                child: Column(
                  children: [
                    _getName(),
                    SizedBox(height: 5.0),
                    _getTextRow(StringConstants.PP_RELIGION, _appDataStorage.userData.religion, () { }),
                    Divider(color: ColorConstants.backGroundGray),
                    _getTextRow(StringConstants.PP_LANGUAGE, _appDataStorage.userData.language, () { }),
                    Divider(color: ColorConstants.backGroundGray),
                    _getTextRow(StringConstants.PP_COUNTRY, _appDataStorage.userData.country, () { }),
                    Divider(color: ColorConstants.backGroundGray),
                    SizedBox(height: 20.0),
                    _getFriendsCard(),
                  ],
                ),
              ),
            ),
            _getCircleAvatar(),
          ],
        ),
      ],
    );
  }

  Widget _getName() {
    return Text(
      _appDataStorage.userData.firstName,
      style: TextStyle(
        fontSize: 22.0,
      ),
    );
  }

  Widget _getTextRow(String text1, String text2, VoidCallback onPressed) {
    return Row(
      children: [
        SizedBox(width: 10.0),
        Text(
          text1,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        IconButton(
          icon: Icon(Icons.edit_outlined, color: ColorConstants.lightPrimaryColor),
          onPressed: onPressed,
        ),
        Spacer(),
        Text(
          text2,
          style: TextStyle(
            fontSize: 16.0,
            color: ColorConstants.gray,
          ),
        ),
        SizedBox(width: 10.0),
      ],
    );
  }

  Widget _getFriendsCard() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: ColorConstants.white,
        shadowColor: ColorConstants.backGroundGray,
        elevation: 6.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: ColorConstants.white,
                    backgroundImage: NetworkImage(
                      'https://www.clearmountainbank.com/wp-content/uploads/2020/04/male-placeholder-image.jpeg',
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: ColorConstants.white,
                    backgroundImage: NetworkImage(
                      'https://www.clearmountainbank.com/wp-content/uploads/2020/04/male-placeholder-image.jpeg',
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: ColorConstants.white,
                    backgroundImage: NetworkImage(
                      'https://www.clearmountainbank.com/wp-content/uploads/2020/04/male-placeholder-image.jpeg',
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: ColorConstants.white,
                    backgroundImage: NetworkImage(
                      'https://www.clearmountainbank.com/wp-content/uploads/2020/04/male-placeholder-image.jpeg',
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: ColorConstants.white,
                    backgroundImage: NetworkImage(
                      'https://www.clearmountainbank.com/wp-content/uploads/2020/04/male-placeholder-image.jpeg',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.0),
              GestureDetector(
                onTap: () => print("All friends"),
                child: Text(
                  StringConstants.PP_SEE_ALL_FRIENDS,
                  style: TextStyle(
                    color: ColorConstants.lightPrimaryColor,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
