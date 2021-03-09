import 'dart:async';

import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/helpers/input_validator.dart';
import 'package:cherished_prayers/helpers/navigation_helper.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/ui/settings_pages/settings_bloc/settings_event.dart';
import 'package:cherished_prayers/ui/settings_pages/settings_screen.dart';
import 'package:cherished_prayers/ui/shared_widgets/custom_text_fileld.dart';
import 'package:cherished_prayers/ui/shared_widgets/logo.dart';
import 'package:cherished_prayers/ui/shared_widgets/rounded_corner_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'settings_bloc/settings_bloc.dart';
import 'settings_bloc/settings_state.dart';

class PasswordChangeScreen extends StatefulWidget {
  @override
  _PasswordChangeScreenState createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
  TextEditingController _passwordController;
  TextEditingController _passwordController2;
  TextEditingController _currentPasswordController;
  bool _obscureText;
  bool _obscureText2;
  bool _obscureText3;
  AppDataStorage _appDataStorage;
  SettingsBloc _settingsBloc;
  StreamSubscription<SettingsState> _settingsBlocListener;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _passwordController2 = TextEditingController();
    _currentPasswordController = TextEditingController();
    _obscureText = true;
    _obscureText2 = true;
    _obscureText3 = true;
    _appDataStorage = RepositoryProvider.of<AppDataStorage>(context);
    _settingsBloc = _appDataStorage.settingsBloc;
    _listenSettingsBloc();
  }

  _listenSettingsBloc() {
    _settingsBlocListener = _settingsBloc.listen((state) async {
      if (state is LoadingSettingsState) {
        EasyLoading.show(
          status: "Changing password...",
        );
      } else if (state is ErrorState) {
        await EasyLoading.dismiss();
        EasyLoading.showError(
          state.error.error + '\n' + state.error.details.join(' ')
        );
      } else if (state is PasswordChangedState) {
        await EasyLoading.dismiss();
        Navigator.of(context).pop();
        NavigationHelper.pushReplacement(context, SettingsScreen(status: "Password Changed successfully."));
      }
    });
  }

  @override
  void dispose() {
    _settingsBlocListener?.cancel();
    _passwordController?.dispose();
    _passwordController2?.dispose();
    _currentPasswordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomLogo(AssetConstants.APP_LOGO, 84.0),
                  _getTitle(),
                  SizedBox(height: 30.0),
                  _getCurrentPasswordField(),
                  SizedBox(height: 15.0),
                  _getPasswordField(),
                  SizedBox(height: 15.0),
                  _getPasswordField2(),
                  SizedBox(height: 40.0),
                  _getChangePasswordButton(context),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTitle() {
    return Text(
      StringConstants.CHANGE_PASSWORD,
      style: TextStyle(
        color: ColorConstants.black,
        fontSize: 36,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _getCurrentPasswordField() {
    return CustomTextField(_currentPasswordController, StringConstants.CURRENT_PASSWORD_HINT, _obscureText3, suffixWidget: _getCurrentPasswordSuffixWidget());
  }

  Widget _getPasswordField() {
    return CustomTextField(_passwordController, StringConstants.NEW_PASSWORD_HINT, _obscureText, suffixWidget: _getSuffixWidget());
  }

  Widget _getPasswordField2() {
    return CustomTextField(_passwordController2, StringConstants.NEW_PASSWORD_2_HINT, _obscureText2, suffixWidget: _getSuffixWidget2());
  }

  Widget _getChangePasswordButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: SizedBox(
        width: double.infinity,
        child: RoundedCornerButton(StringConstants.CHANGE_PASSWORD_BUTTON, _changePassword),
      ),
    );
  }

  Widget _getSuffixWidget() {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0, top: 12.0),
      child: GestureDetector(
        child: Text(
          _obscureText ? StringConstants.SHOW : StringConstants.HIDE,
          style: TextStyle(
            fontSize: 16,
            color: ColorConstants.lightPrimaryColor,
          ),
        ),
        onTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
    );
  }

  Widget _getSuffixWidget2() {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0, top: 12.0),
      child: GestureDetector(
        child: Text(
          _obscureText2 ? StringConstants.SHOW : StringConstants.HIDE,
          style: TextStyle(
            fontSize: 16,
            color: ColorConstants.lightPrimaryColor,
          ),
        ),
        onTap: () {
          setState(() {
            _obscureText2 = !_obscureText2;
          });
        },
      ),
    );
  }

  Widget _getCurrentPasswordSuffixWidget() {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0, top: 12.0),
      child: GestureDetector(
        child: Text(
          _obscureText3 ? StringConstants.SHOW : StringConstants.HIDE,
          style: TextStyle(
            fontSize: 16,
            color: ColorConstants.lightPrimaryColor,
          ),
        ),
        onTap: () {
          setState(() {
            _obscureText3 = !_obscureText3;
          });
        },
      ),
    );
  }

  void _changePassword() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    String _currentPassword = _currentPasswordController.text;
    String _password = _passwordController.text;
    String _password2 = _passwordController2.text;

    if (_password != _password2) {
      EasyLoading.showToast(
        StringConstants.BOTH_PASSWORD_MUST_MATCH,
        duration: Duration(seconds: 3),
        toastPosition: EasyLoadingToastPosition.bottom,
        dismissOnTap: true,
      );
    } else if (!validatePassword(_password) | !validatePassword(_currentPassword)) {
      EasyLoading.showToast(
        StringConstants.PASSWORD_ERROR,
        duration: Duration(seconds: 3),
        toastPosition: EasyLoadingToastPosition.bottom,
        dismissOnTap: true,
      );
    } else {
      ChangePasswordRequest changePasswordRequest = ChangePasswordRequest(
        _currentPassword,
        _password,
        _password2,
      );
      _settingsBloc.add(ChangePasswordEvent(changePasswordRequest, _appDataStorage.authToken));
    }

  }
}
