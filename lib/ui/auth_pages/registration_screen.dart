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
import 'package:cherished_prayers/ui/shared_widgets/custom_text_fileld.dart';
import 'package:cherished_prayers/ui/shared_widgets/logo.dart';
import 'package:cherished_prayers/ui/shared_widgets/rounded_corner_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'auth_bloc/auth_bloc.dart';
import 'auth_bloc/auth_state.dart';
import 'otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  bool _obscureText;
  AppDataStorage _appDataStorage;
  AuthBloc _authBloc;
  StreamSubscription<AuthState> _authBlocListener;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _obscureText = true;
    _appDataStorage = RepositoryProvider.of<AppDataStorage>(context);
    _authBloc = _appDataStorage.authBloc;
    _listenAuthBloc();
  }

  _listenAuthBloc() {
    _authBlocListener = _authBloc.listen((state) async {
      if (state is LoadingState) {
        EasyLoading.show(
          status: "Sending email...",
        );
      } else if (state is ErrorState) {
        await EasyLoading.dismiss();
        EasyLoading.showError(
            state.error.error + '\n' + state.error.details.join(' ')
        );
      } else if (state is EmailSentState) {
        await EasyLoading.dismiss();
        NavigationHelper.push(context, OTPScreen());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameController?.dispose();
    _emailController?.dispose();
    _passwordController?.dispose();
    _authBlocListener?.cancel();
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomLogo(AssetConstants.APP_LOGO, 84.0),
                  _getTitle(),
                  SizedBox(height: 20.0),
                  _getNameField(),
                  SizedBox(height: 15.0),
                  _getEmailField(),
                  SizedBox(height: 15.0),
                  _getPasswordField(),
                  SizedBox(height: 30.0),
                  _getSignUpButton(context),
                  SizedBox(height: 30.0),
                  _getSignInLink(),
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
      StringConstants.SIGN_UP_TITLE,
      style: TextStyle(
        color: ColorConstants.black,
        fontSize: 36,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _getNameField() {
    return CustomTextField(_nameController, StringConstants.NAME_HINT, false);
  }

  Widget _getEmailField() {
    return CustomTextField(_emailController, StringConstants.EMAIL_HINT, false);
  }

  Widget _getPasswordField() {
    return CustomTextField(_passwordController, StringConstants.PASSWORD_HINT, _obscureText, suffixWidget: _getSuffixWidget());
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

  Widget _getSignUpButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: SizedBox(
        width: double.infinity,
        child: RoundedCornerButton(StringConstants.SIGN_UP, _sendOTP),
      ),
    );
  }

  Widget _getSignInLink() {
    return GestureDetector(
      child: Align(
        alignment: Alignment.center,
        child: RichText(
          text: TextSpan(
            text: StringConstants.HAVE_ACCOUNT,
            style: TextStyle(
              color: ColorConstants.black,
              fontSize: 16,
            ),
            children: [
              TextSpan(
                text: StringConstants.SIGN_IN_LINK,
                style: TextStyle(
                  color: ColorConstants.lightPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () => NavigationHelper.push(context, LoginScreen()),
    );
  }

  void _sendOTP() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    String _name = _nameController.text.trim();
    String _email = _emailController.text.trim();
    String _password = _passwordController.text.trim();

    if (!validateName(_name)) {
      EasyLoading.showToast(
        StringConstants.NAME_ERROR,
        duration: Duration(seconds: 3),
        toastPosition: EasyLoadingToastPosition.bottom,
        dismissOnTap: true,
      );
    } else if (!validateEmail(_email)) {
      EasyLoading.showToast(
        StringConstants.EMAIL_ERROR,
        duration: Duration(seconds: 3),
        toastPosition: EasyLoadingToastPosition.bottom,
        dismissOnTap: true,
      );
    }
    else if (!validatePassword(_password)) {
      EasyLoading.showToast(
        StringConstants.PASSWORD_ERROR,
        duration: Duration(seconds: 3),
        toastPosition: EasyLoadingToastPosition.bottom,
        dismissOnTap: true,
      );
    }
    else {
      RegisterRequest registerRequest = RegisterRequest(_email, _name, "", _password);
      VerifyEmailRequest verifyEmailRequest = VerifyEmailRequest(_email);
      _appDataStorage.registerRequest = registerRequest;
      _authBloc.add(VerifyEmailEvent(verifyEmailRequest));
    }
  }
}
