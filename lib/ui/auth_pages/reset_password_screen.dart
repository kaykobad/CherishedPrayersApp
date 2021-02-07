import 'dart:async';

import 'package:cherished_prayers/constants/asset_constants.dart';
import 'package:cherished_prayers/constants/color_constants.dart';
import 'package:cherished_prayers/constants/string_constants.dart';
import 'package:cherished_prayers/data/models/models.dart';
import 'package:cherished_prayers/helpers/input_validator.dart';
import 'package:cherished_prayers/helpers/navigation_helper.dart';
import 'package:cherished_prayers/repository/app_data_storage.dart';
import 'package:cherished_prayers/ui/auth_pages/auth_bloc/auth_event.dart';
import 'package:cherished_prayers/ui/auth_pages/login_screen.dart';
import 'package:cherished_prayers/ui/auth_pages/otp_screen.dart';
import 'package:cherished_prayers/ui/shared_widgets/custom_text_fileld.dart';
import 'package:cherished_prayers/ui/shared_widgets/logo.dart';
import 'package:cherished_prayers/ui/shared_widgets/rounded_corner_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'auth_bloc/auth_bloc.dart';
import 'auth_bloc/auth_state.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController _passwordController;
  TextEditingController _passwordController2;
  bool _obscureText;
  bool _obscureText2;
  AppDataStorage _appDataStorage;
  AuthBloc _authBloc;
  StreamSubscription<AuthState> _authBlocListener;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _passwordController2 = TextEditingController();
    _obscureText = true;
    _obscureText2 = true;
    _appDataStorage = RepositoryProvider.of<AppDataStorage>(context);
    _authBloc = _appDataStorage.authBloc;
    _listenAuthBloc();
  }

  _listenAuthBloc() {
    _authBlocListener = _authBloc.listen((state) async {
      if (state is LoadingState) {
        EasyLoading.show(
          status: "Resetting password...",
        );
      } else if (state is ErrorState) {
        await EasyLoading.dismiss();

        if (state.error.error == "Security code invalid or expired.") {
          NavigationHelper.pushReplacement(context, OTPScreen(isRegistration: false, status: "Please provide a valid OTP.",));
        } else {
          EasyLoading.showError(
            state.error.error + '\n' + state.error.details.join(' ')
          );
        }
      } else if (state is PasswordResetConfirmedState) {
        await EasyLoading.dismiss();
        NavigationHelper.push(context, LoginScreen(isFromPasswordReset: true));
      }
    });
  }

  @override
  void dispose() {
    _authBlocListener?.cancel();
    _passwordController?.dispose();
    _passwordController2?.dispose();
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
                  _getPasswordField(),
                  SizedBox(height: 15.0),
                  _getPasswordField2(),
                  SizedBox(height: 40.0),
                  _getResetPasswordButton(context),
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
      StringConstants.RESET_PASSWORD,
      style: TextStyle(
        color: ColorConstants.black,
        fontSize: 36,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _getPasswordField() {
    return CustomTextField(_passwordController, StringConstants.NEW_PASSWORD_HINT, _obscureText, suffixWidget: _getSuffixWidget());
  }

  Widget _getPasswordField2() {
    return CustomTextField(_passwordController2, StringConstants.NEW_PASSWORD_2_HINT, _obscureText2, suffixWidget: _getSuffixWidget2());
  }

  Widget _getResetPasswordButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: SizedBox(
        width: double.infinity,
        child: RoundedCornerButton(StringConstants.RESET_PASSWORD_BUTTON, _resetPassword),
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

  void _resetPassword() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    String _password = _passwordController.text;
    String _password2 = _passwordController2.text;

    if (_password != _password2) {
      EasyLoading.showToast(
        StringConstants.BOTH_PASSWORD_MUST_MATCH,
        duration: Duration(seconds: 3),
        toastPosition: EasyLoadingToastPosition.bottom,
        dismissOnTap: true,
      );
    } else if (!validatePassword(_password)) {
      EasyLoading.showToast(
        StringConstants.PASSWORD_ERROR,
        duration: Duration(seconds: 3),
        toastPosition: EasyLoadingToastPosition.bottom,
        dismissOnTap: true,
      );
    } else {
      ConfirmPasswordResetRequest confirmPasswordResetRequest = ConfirmPasswordResetRequest(
        _appDataStorage.passwordResetEmail,
        _appDataStorage.passwordResetOTP,
        _password,
        _password2,
      );
      _authBloc.add(ConfirmResetPasswordEvent(confirmPasswordResetRequest));
    }

  }
}
