import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/data/network/api_endpoints.dart';
import 'package:cherished_prayers/helpers/firebase_helper.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/ui/profile_tos_pp_feedback/profile_and_feedback_bloc/profile_and_feedback_event.dart';
import 'package:cherished_prayers/ui/shared_widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import 'profile_and_feedback_bloc/profile_and_feedback_bloc.dart';
import 'profile_and_feedback_bloc/profile_and_feedback_state.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double _height;
  double _width;
  AppDataStorage _appDataStorage;
  ProfileAndFeedbackBloc _profileBloc;
  StreamSubscription<ProfileAndFeedbackState> _listenProfileState;
  String _authToken;
  String _selectedValue;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _appDataStorage = RepositoryProvider.of<AppDataStorage>(context);
    _profileBloc = ProfileAndFeedbackBloc(ProfileAndFeedbackInitialState());
    _authToken = RepositoryProvider.of<AppDataStorage>(context).authToken;
    _listenProfileBloc();
  }

  _listenProfileBloc() {
    _listenProfileState = _profileBloc.listen((state) async {
      if (state is ProfileAndFeedbackLoadingState) {
        EasyLoading.show(
          status: "Updating data...",
        );
      } else if (state is ProfileAndFeedbackErrorState) {
        await EasyLoading.dismiss();
        EasyLoading.showError(
          state.error.error + '\n' + state.error.details.join(' '),
        );
      } else if (state is ProfilePictureUpdatedState) {
        await EasyLoading.dismiss();
        EasyLoading.showSuccess(state.updateProfilePictureResponse.detail);
        _appDataStorage.userData.avatar = state.updateProfilePictureResponse.avatar;
        addUserToFirebase(_appDataStorage.userData);
        setState(() {});
      } else if (state is AllCountriesFetchedState) {
        await EasyLoading.dismiss();
        _appDataStorage.allCountries = state.allCountriesResponse.countries;
        List<String> values = _getData(1);
        showSelectionDialog("Update Country", values, "Select Country", 1);
      } else if (state is AllLanguagesFetchedState) {
        await EasyLoading.dismiss();
        _appDataStorage.allLanguages = state.allLanguagesResponse.languages;
        List<String> values = _getData(2);
        showSelectionDialog("Update Language", values, "Select Language", 2);
      } else if (state is AllReligionsFetchedState) {
        await EasyLoading.dismiss();
        _appDataStorage.allReligions = state.allReligionsResponse.religions;
        List<String> values = _getData(3);
        showSelectionDialog("Update Religion", values, "Select Religion", 3);
      } else if (state is CLRUpdatedState) {
        await EasyLoading.dismiss();
        if (state.selector == 1) _appDataStorage.userData.country = _selectedValue;
        else if (state.selector == 2) _appDataStorage.userData.language = _selectedValue;
        else _appDataStorage.userData.religion = _selectedValue;
        EasyLoading.showSuccess(state.detailOnlyResponse.detail);
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _listenProfileState?.cancel();
    _profileBloc?.close();
    super.dispose();
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
            CustomAvatar(url: _appDataStorage.userData.avatar == null ? null : ApiEndpoints.URL_ROOT + _appDataStorage.userData.avatar, size: 160),
            Align(
              alignment: Alignment.bottomRight,
              child: MaterialButton(
                onPressed: _getImage,
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

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      UpdateProfilePictureRequest updateProfilePictureRequest = UpdateProfilePictureRequest(pickedFile.path);
      _profileBloc.add(UpdateProfilePictureEvent(updateProfilePictureRequest, _authToken));
    } else {
      EasyLoading.showToast(
        "No picture selected.",
        duration: Duration(seconds: 3),
        dismissOnTap: true,
        toastPosition: EasyLoadingToastPosition.bottom,
      );
    }
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
                    _getTextRow(StringConstants.PP_RELIGION, _appDataStorage.userData.religion, () {
                      _selectedValue = null;
                      if (_appDataStorage.allReligions == null) {
                        _profileBloc.add(FetchAllReligionsEvent());
                      } else {
                        List<String> values = _getData(3);
                        showSelectionDialog("Update Religion", values, "Select Religion", 3);
                      }
                    }),
                    Divider(color: ColorConstants.backGroundGray),
                    _getTextRow(StringConstants.PP_LANGUAGE, _appDataStorage.userData.language, () {
                      _selectedValue = null;
                      if (_appDataStorage.allLanguages == null) {
                        _profileBloc.add(FetchAllLanguagesEvent());
                      } else {
                        List<String> values = _getData(2);
                        showSelectionDialog("Update Language", values, "Select Language", 2);
                      }
                    }),
                    Divider(color: ColorConstants.backGroundGray),
                    _getTextRow(StringConstants.PP_COUNTRY, _appDataStorage.userData.country, () {
                      _selectedValue = null;
                      if (_appDataStorage.allCountries == null) {
                        _profileBloc.add(FetchAllCountriesEvent());
                      } else {
                        List<String> values = _getData(1);
                        showSelectionDialog("Update Country", values, "Select Country", 1);
                      }
                    }),
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

  // Selector: for selecting update category
  // 1: Country, 2: Language, 3: religion
  List<String> _getData(int selector) {
    List<String> values = [];

    if (selector == 1) {
      for (CountryModel e in _appDataStorage.allCountries) {
        values.add(e.country);
      }
    } else if (selector == 2) {
      for (LanguageModel e in _appDataStorage.allLanguages) {
        values.add(e.language);
      }
    } else if (selector == 3) {
      for (ReligionModel e in _appDataStorage.allReligions) {
        values.add(e.religion);
      }
    }

    return values;
  }

  void showSelectionDialog(String title, List<String> values, String hint, int selector) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text(title),
        content: DropdownButton<String>(
          value: _selectedValue,
          isExpanded: true,
          items: values.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (s) {
            _selectedValue = s;
            UpdateValueRequest updateValueRequest = UpdateValueRequest(_selectedValue);
            _profileBloc.add(UpdateCLREvent(updateValueRequest, _authToken, selector));
            Navigator.of(context).pop();
          },
          hint: Text(hint),
        ),
      ),
    );
  }
}
